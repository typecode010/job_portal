from accounts.models import AccountProfile
from django.contrib.auth.models import User
from notifications.models import Notification
from notifications.services import notify_users
from profiles.models import UserProfile

from .models import JobPost


def normalize_skills(skills_text):
    if not skills_text:
        return set()

    normalized = set()
    for token in skills_text.replace(';', ',').split(','):
        cleaned = token.strip().lower()
        if cleaned:
            normalized.add(cleaned)
    return normalized


def calculate_job_match_score(user_profile, job):
    candidate_skills = normalize_skills(user_profile.skills_text)
    required_skills = normalize_skills(job.required_skills)

    if required_skills:
        overlap = len(candidate_skills.intersection(required_skills))
        skill_points = int((overlap / len(required_skills)) * 70)
    else:
        skill_points = 35

    experience_points = 20 if user_profile.experience_summary.strip() else 8

    location_points = 0
    profile_location = user_profile.location.strip().lower() if user_profile.location else ''
    job_location = job.location.strip().lower() if job.location else ''
    if job.job_type == JobPost.JOB_TYPE_REMOTE:
        location_points = 10
    elif profile_location and job_location and profile_location in job_location:
        location_points = 10

    score = min(100, skill_points + experience_points + location_points)

    explanation_parts = [
        f'Skills {skill_points}/70',
        f'Experience {experience_points}/20',
        f'Location {location_points}/10',
    ]

    return score, ' | '.join(explanation_parts)


def get_suggested_jobs_for_user(user, queryset=None, limit=5):
    profile = UserProfile.objects.filter(user=user).first()
    if profile is None:
        return []

    jobs_queryset = queryset if queryset is not None else JobPost.objects.filter(
        is_active=True,
        approval_status=JobPost.STATUS_APPROVED,
    )

    scored_jobs = []
    for job in jobs_queryset[:100]:
        score, explanation = calculate_job_match_score(profile, job)
        scored_jobs.append(
            {
                'job': job,
                'score': score,
                'explanation': explanation,
            }
        )

    scored_jobs.sort(key=lambda item: (-item['score'], -item['job'].created_at.timestamp()))
    return scored_jobs[:limit]


def notify_job_seekers_for_new_job(job, actor):
    recipient_ids = AccountProfile.objects.filter(role=AccountProfile.ROLE_STUDENT).exclude(
        user=actor,
    ).values_list('user_id', flat=True)
    recipients = User.objects.filter(id__in=recipient_ids, is_active=True)

    notify_users(
        recipients=recipients,
        title=f'New job posted: {job.title}',
        message=(
            f'{job.company_name} posted a new {job.get_job_type_display()} opportunity '
            f'in {job.location or "Unspecified location"}.'
        ),
        notification_type=Notification.TYPE_NEW_JOB,
        actor=actor,
        action_url=f'/job_portal/jobs/{job.id}/',
        send_email=True,
    )
