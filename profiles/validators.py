from django.core.exceptions import ValidationError


MAX_RESUME_FILE_SIZE_BYTES = 5 * 1024 * 1024


def validate_resume_pdf_file(uploaded_file):
    if not uploaded_file:
        raise ValidationError('Resume file is required.')

    file_name = (uploaded_file.name or '').lower().strip()
    if not file_name.endswith('.pdf'):
        raise ValidationError('Only PDF files are allowed.')

    if uploaded_file.size > MAX_RESUME_FILE_SIZE_BYTES:
        raise ValidationError('Resume size must be 5MB or less.')
