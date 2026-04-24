import shutil
import subprocess
from pathlib import Path

from django.conf import settings
from django.utils import timezone

from .models import AdminActionLog, DatabaseBackup


def log_admin_action(*, admin_user, action_type, target_type='', target_id='', note=''):
    return AdminActionLog.objects.create(
        admin_user=admin_user,
        action_type=action_type,
        target_type=target_type,
        target_id=str(target_id or ''),
        note=note,
    )


def _resolve_mysqldump_executable():
    configured_executable = getattr(settings, 'MYSQLDUMP_EXECUTABLE', '').strip()
    if configured_executable:
        configured_path = Path(configured_executable)
        if configured_path.exists():
            return str(configured_path)
        return configured_executable

    discovered = shutil.which('mysqldump')
    if discovered:
        return discovered

    windows_default = Path('C:/xampp/mysql/bin/mysqldump.exe')
    if windows_default.exists():
        return str(windows_default)

    return ''


def _cleanup_old_backups():
    retention_count = int(getattr(settings, 'BACKUP_RETENTION_COUNT', 5) or 0)
    if retention_count <= 0:
        return

    stale_backups = list(DatabaseBackup.objects.order_by('-created_at')[retention_count:])
    for backup in stale_backups:
        backup_path = Path(backup.file_path)
        if backup_path.exists():
            try:
                backup_path.unlink()
            except OSError:
                pass

    if stale_backups:
        DatabaseBackup.objects.filter(id__in=[item.id for item in stale_backups]).delete()


def create_database_backup(*, created_by):
    db_config = settings.DATABASES.get('default', {})
    if 'mysql' not in str(db_config.get('ENGINE', '')).lower():
        return {
            'success': False,
            'message': 'Backup utility currently supports MySQL only.',
        }

    db_name = str(db_config.get('NAME', '')).strip()
    db_user = str(db_config.get('USER', '')).strip()
    db_password = str(db_config.get('PASSWORD', '')).strip()
    db_host = str(db_config.get('HOST', '127.0.0.1')).strip() or '127.0.0.1'
    db_port = str(db_config.get('PORT', '3306')).strip() or '3306'

    if not db_name or not db_user:
        return {
            'success': False,
            'message': 'MySQL database settings are incomplete.',
        }

    mysqldump_executable = _resolve_mysqldump_executable()
    if not mysqldump_executable:
        return {
            'success': False,
            'message': 'mysqldump executable not found. Configure MYSQLDUMP_EXECUTABLE in settings.',
        }

    backup_root = Path(getattr(settings, 'BACKUP_ROOT', settings.BASE_DIR / 'backups'))
    backup_root.mkdir(parents=True, exist_ok=True)

    timestamp = timezone.now().strftime('%Y%m%d_%H%M%S')
    filename = f'job_portal_backup_{timestamp}.sql'
    backup_file_path = backup_root / filename

    command = [
        mysqldump_executable,
        f'--host={db_host}',
        f'--port={db_port}',
        f'--user={db_user}',
        f'--password={db_password}',
        '--single-transaction',
        '--quick',
        '--result-file',
        str(backup_file_path),
        db_name,
    ]

    try:
        completed = subprocess.run(command, capture_output=True, text=True, check=False)
    except OSError:
        return {
            'success': False,
            'message': 'Failed to execute mysqldump command.',
        }

    if completed.returncode != 0:
        if backup_file_path.exists():
            try:
                backup_file_path.unlink()
            except OSError:
                pass

        return {
            'success': False,
            'message': 'Backup command failed. Verify MySQL service, credentials, and mysqldump path.',
        }

    if not backup_file_path.exists():
        return {
            'success': False,
            'message': 'Backup command finished but no backup file was produced.',
        }

    file_size = backup_file_path.stat().st_size
    backup_record = DatabaseBackup.objects.create(
        filename=filename,
        file_path=str(backup_file_path),
        file_size_bytes=file_size,
        created_by=created_by,
    )

    log_admin_action(
        admin_user=created_by,
        action_type=AdminActionLog.ACTION_BACKUP_CREATED,
        target_type='DatabaseBackup',
        target_id=backup_record.id,
        note=f'Created backup file: {filename} ({file_size} bytes)',
    )

    _cleanup_old_backups()

    return {
        'success': True,
        'message': f'Backup created successfully: {filename}',
        'backup': backup_record,
    }
