# Architecture Summary

## Overview
The project uses a monolithic Django architecture with modular app boundaries for maintainability and role-based behavior.

## Layers
- Presentation Layer: Django templates + Bootstrap UI
- Application Layer: URL routing + view handlers per app
- Domain/Service Layer: Matching logic, notifications, reporting, backup/audit services
- Data Layer: MySQL (XAMPP localhost), Django ORM models and migrations
- File Storage: Media uploads (resumes) + SQL backups folder

## App Responsibilities
- core: home and shared entry points
- accounts: authentication, email verification, password reset, role onboarding
- profiles: profile update, resume upload/validation
- jobs: posting, discovery, filtering, bookmarking, apply trigger
- applications: status tracking and employer/alumni management
- messaging: applicant-job-owner conversation threads
- notifications: in-app + optional email dispatch
- dashboard: role dashboards and admin moderation panels
- reports: analytics, CSV/PDF export, feedback, backup utility, audit logs

## Request Flow (Typical)
1. Browser sends request to Django URL.
2. View validates authentication/role permissions.
3. Business logic executes with model/service calls.
4. ORM reads/writes MySQL records.
5. Template or file response returned.
6. Notifications/audit entries are created for key events.

## Security Controls in Current Build
- Role-based route and action checks on protected views.
- Login throttling lockout for repeated failures.
- CSRF middleware enabled for forms.
- Server-side validation for key forms.
- Resume upload validator enforced in form and model.
- Admin-only guards for moderation, reports, feedback-manage, backups.
- Audit log entries for sensitive admin operations.
