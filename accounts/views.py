from django.contrib import messages
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from django.conf import settings
from django.core.cache import cache
from django.core import signing
from django.core.mail import send_mail
from django.shortcuts import redirect, render
from django.urls import reverse
from django.utils import timezone

from .forms import LoginForm, RegisterForm, ResendVerificationEmailForm
from .models import AccountProfile


EMAIL_VERIFICATION_SALT = 'accounts.email.verification'
EMAIL_VERIFICATION_MAX_AGE_SECONDS = 60 * 60 * 24 * 3


def _get_client_ip(request):
    forwarded_for = (request.META.get('HTTP_X_FORWARDED_FOR') or '').strip()
    if forwarded_for:
        return forwarded_for.split(',')[0].strip()
    return (request.META.get('REMOTE_ADDR') or 'unknown').strip()


def _get_login_throttle_values():
    max_attempts = int(getattr(settings, 'LOGIN_MAX_ATTEMPTS', 5) or 5)
    lockout_seconds = int(getattr(settings, 'LOGIN_LOCKOUT_SECONDS', 300) or 300)
    return max(1, max_attempts), max(30, lockout_seconds)


def _build_login_throttle_key(email, client_ip):
    return f'accounts.login.attempts:{email.lower()}:{client_ip}'


def _get_lockout_remaining_seconds(email, client_ip):
    cache_key = _build_login_throttle_key(email, client_ip)
    state = cache.get(cache_key) or {}
    lock_until = float(state.get('lock_until') or 0)
    now_ts = timezone.now().timestamp()
    if lock_until <= now_ts:
        return 0
    return int(lock_until - now_ts)


def _record_failed_login_attempt(email, client_ip):
    max_attempts, lockout_seconds = _get_login_throttle_values()
    cache_key = _build_login_throttle_key(email, client_ip)
    state = cache.get(cache_key) or {'attempts': 0, 'lock_until': 0}

    now_ts = timezone.now().timestamp()
    lock_until = float(state.get('lock_until') or 0)
    if lock_until > now_ts:
        return int(lock_until - now_ts)

    attempts = int(state.get('attempts') or 0) + 1
    lock_until = 0
    if attempts >= max_attempts:
        lock_until = now_ts + lockout_seconds

    cache.set(
        cache_key,
        {
            'attempts': attempts,
            'lock_until': lock_until,
        },
        timeout=max(lockout_seconds, 60),
    )

    if lock_until:
        return lockout_seconds
    return 0


def _clear_failed_login_attempts(email, client_ip):
    cache.delete(_build_login_throttle_key(email, client_ip))


def build_email_verification_token(user):
    return signing.dumps(
        {
            'user_id': user.id,
            'email': user.email,
        },
        salt=EMAIL_VERIFICATION_SALT,
    )


def send_verification_email(request, user):
    token = build_email_verification_token(user)
    verify_path = reverse('accounts:verify_email')
    verify_url = request.build_absolute_uri(f'{verify_path}?token={token}')

    send_mail(
        subject='Verify your email address',
        message=(
            f'Hello {user.first_name or user.username},\n\n'
            f'Please verify your email by opening this link:\n{verify_url}\n\n'
            'After verification, your account will be reviewed by admin.\n\n'
            'If you did not create this account, ignore this email.'
        ),
        from_email=settings.DEFAULT_FROM_EMAIL,
        recipient_list=[user.email],
        fail_silently=True,
    )


def register_view(request):
    if request.user.is_authenticated:
        return redirect('/job_portal/')

    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            user = form.save()
            send_verification_email(request, user)
            messages.success(
                request,
                'Registration successful. Check your email to verify your account, then wait for admin approval.',
            )
            return redirect('/job_portal/accounts/login/')
    else:
        form = RegisterForm()

    return render(request, 'accounts/register.html', {'form': form})


def login_view(request):
    if request.user.is_authenticated:
        return redirect('/job_portal/')

    if request.method == 'POST':
        form = LoginForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email'].lower().strip()
            password = form.cleaned_data['password']
            client_ip = _get_client_ip(request)

            lockout_remaining = _get_lockout_remaining_seconds(email, client_ip)
            if lockout_remaining > 0:
                lockout_minutes = max(1, (lockout_remaining + 59) // 60)
                messages.error(
                    request,
                    f'Too many failed login attempts. Try again in {lockout_minutes} minute(s).',
                )
                return render(request, 'accounts/login.html', {'form': form})

            matched_user = User.objects.filter(email__iexact=email).first()
            password_valid = bool(matched_user and matched_user.check_password(password))

            if not password_valid:
                lockout_remaining = _record_failed_login_attempt(email, client_ip)
                if lockout_remaining > 0:
                    lockout_minutes = max(1, (lockout_remaining + 59) // 60)
                    messages.error(
                        request,
                        f'Too many failed login attempts. Try again in {lockout_minutes} minute(s).',
                    )
                else:
                    messages.error(request, 'Invalid email or password.')
                return render(request, 'accounts/login.html', {'form': form})

            _clear_failed_login_attempts(email, client_ip)

            if matched_user is not None:
                profile = AccountProfile.objects.filter(user=matched_user).first()

                if not (matched_user.is_superuser or matched_user.is_staff):
                    email_verified = profile.email_verified if profile else True
                    if not email_verified:
                        messages.warning(
                            request,
                            'Please verify your email before login. You can resend the verification email if needed.',
                        )
                        return render(request, 'accounts/login.html', {'form': form})

                if not matched_user.is_active:
                    if profile and profile.moderation_status == AccountProfile.STATUS_PENDING:
                        messages.warning(request, 'Your account is pending admin approval.')
                    elif profile and profile.moderation_status == AccountProfile.STATUS_REJECTED:
                        messages.error(request, 'Your account access has been disabled by admin.')
                    else:
                        messages.error(request, 'Your account is currently inactive.')
                    return render(request, 'accounts/login.html', {'form': form})

                auth_user = authenticate(request, username=matched_user.username, password=password)
                if auth_user is not None:
                    login(request, auth_user)
                    return redirect('/job_portal/dashboard/')

            messages.error(request, 'Unable to log in right now. Please try again.')
    else:
        form = LoginForm()

    return render(request, 'accounts/login.html', {'form': form})


def logout_view(request):
    logout(request)
    messages.info(request, 'You have been logged out.')
    return redirect('/job_portal/')


def verify_email_view(request):
    token = request.GET.get('token', '').strip()
    if not token:
        messages.error(request, 'Verification token is missing.')
        return redirect('accounts:resend_verification')

    try:
        payload = signing.loads(
            token,
            salt=EMAIL_VERIFICATION_SALT,
            max_age=EMAIL_VERIFICATION_MAX_AGE_SECONDS,
        )
    except signing.SignatureExpired:
        messages.error(request, 'Verification link has expired. Please request a new one.')
        return redirect('accounts:resend_verification')
    except signing.BadSignature:
        messages.error(request, 'Invalid verification link. Please request a new one.')
        return redirect('accounts:resend_verification')

    user = User.objects.filter(
        id=payload.get('user_id'),
        email__iexact=payload.get('email', ''),
    ).first()
    if user is None:
        messages.error(request, 'Unable to verify this account. Please request a new verification email.')
        return redirect('accounts:resend_verification')

    profile, _ = AccountProfile.objects.get_or_create(
        user=user,
        defaults={
            'role': AccountProfile.ROLE_STUDENT,
            'moderation_status': AccountProfile.STATUS_PENDING,
            'email_verified': False,
        },
    )

    if not profile.email_verified:
        profile.email_verified = True
        profile.save(update_fields=['email_verified', 'updated_at'])

    if profile.moderation_status == AccountProfile.STATUS_APPROVED:
        if not user.is_active:
            user.is_active = True
            user.save(update_fields=['is_active'])
        messages.success(request, 'Email verified successfully. You can now log in.')
    elif profile.moderation_status == AccountProfile.STATUS_REJECTED:
        if user.is_active:
            user.is_active = False
            user.save(update_fields=['is_active'])
        messages.info(request, 'Email verified, but your account is currently disabled by admin.')
    else:
        if user.is_active:
            user.is_active = False
            user.save(update_fields=['is_active'])
        messages.success(request, 'Email verified. Your account is now waiting for admin approval.')

    return redirect('accounts:login')


def resend_verification_email_view(request):
    if request.user.is_authenticated:
        return redirect('/job_portal/')

    if request.method == 'POST':
        form = ResendVerificationEmailForm(request.POST)
        if form.is_valid():
            email = form.cleaned_data['email'].lower().strip()
            user = User.objects.filter(email__iexact=email).first()

            if user and not (user.is_superuser or user.is_staff):
                profile, _ = AccountProfile.objects.get_or_create(
                    user=user,
                    defaults={
                        'role': AccountProfile.ROLE_STUDENT,
                        'moderation_status': AccountProfile.STATUS_PENDING,
                        'email_verified': False,
                    },
                )

                if not profile.email_verified:
                    send_verification_email(request, user)

            messages.success(
                request,
                'If an unverified account exists for this email, a verification link has been sent.',
            )
            return redirect('accounts:login')
    else:
        form = ResendVerificationEmailForm()

    return render(
        request,
        'accounts/resend_verification.html',
        {
            'form': form,
        },
    )
