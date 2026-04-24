# Test Evidence (Phase 8)

## Summary
This document captures manual QA evidence for core and optional modules for viva/demo readiness.

## Test Matrix

| Scenario ID | Role | Steps | Expected Result | Actual Result | Status | Notes |
|---|---|---|---|---|---|---|
| QA-AUTH-01 | Student | Register -> verify/approved -> login | Account can login and land on role dashboard | Successful in local validation flow | Pass | Verification + moderation gates honored |
| QA-AUTH-02 | Any | Enter wrong password repeatedly | Temporary lockout after configured failures | Lockout message appears with wait time | Pass | Cache-based throttling |
| QA-PROFILE-01 | Student | Open profile -> update fields -> save | Profile data persists and success message shown | Saved and reloaded correctly | Pass | Includes visibility field |
| QA-RESUME-01 | Student | Upload valid PDF under 5MB | Resume uploads and becomes active | Upload successful | Pass | Previous active resume deactivated |
| QA-RESUME-02 | Student | Upload invalid type or >5MB file | Validation rejects upload | Form validation blocks file | Pass | Form + model validators aligned |
| QA-JOB-01 | Employer/Alumni | Create job | Job created and visible in manage list | Created with pending status | Pass | Admin approval required for public visibility |
| QA-JOB-02 | Student | Filter jobs by keyword/location/type/skills | Filtered list reflects criteria | Filtered results returned correctly | Pass | Matching cards still visible |
| QA-APP-01 | Student | Apply to approved job with active resume | Application created with status Applied | Application submitted successfully | Pass | Duplicate applications blocked |
| QA-APP-02 | Employer | Update applicant status | Applicant sees updated status + notification | Status updated and notification present | Pass | Notification email/in-app triggered |
| QA-MSG-01 | Applicant | Open conversation from My Applications -> send message | Thread opens and message is saved | Message visible in chronological history | Pass | One thread per application |
| QA-MSG-02 | Employer | Open conversation from Manage Applications -> reply | Same thread reused and reply sent | Reply stored and recipient notified | Pass | Participant-only send access |
| QA-MSG-03 | Unauthorized user | Access thread URL directly | Access denied and redirected | Redirected to dashboard home | Pass | Access control enforced |
| QA-NOTIF-01 | Authenticated user | Open notifications center -> mark read | Notification read status updates | Updated correctly | Pass | Mark single + mark all available |
| QA-REPORT-01 | Admin | Open reports with filters | Metrics and rows match selected filters | Filtered output renders correctly | Pass | Pagination preserved |
| QA-REPORT-02 | Admin | Export CSV/PDF | Files download with report data | Downloads successful | Pass | CSV + PDF endpoints verified |
| QA-FEEDBACK-01 | User | Submit feedback ticket | Ticket saved and admin notified | Ticket created with notification | Pass | Feedback history visible to submitter |
| QA-FEEDBACK-02 | Admin | Update feedback status + notes | User notified and audit log added | Update reflected with log entry | Pass | Status filter works |
| QA-BACKUP-01 | Admin | Open backups page -> Create Backup | SQL backup file created and listed | Backup created and listed | Pass | Metadata persisted in DB |
| QA-BACKUP-02 | Non-admin | Access backup URLs | Access blocked | Redirected to dashboard with error | Pass | Admin-only protection confirmed |
| QA-BACKUP-03 | Admin | Trigger backup when command fails | Graceful error message shown | Error shown without sensitive details | Pass | No raw stderr exposed |
| QA-AUDIT-01 | Admin | Moderate job/user + create backup | Audit records created for sensitive actions | Logs present in AdminActionLog | Pass | Includes feedback status updates |

## Screenshot Checklist (Placeholders)
- [ ] Student dashboard overview: `docs/screenshots/student_dashboard.png`
- [ ] Alumni dashboard quick actions: `docs/screenshots/alumni_dashboard.png`
- [ ] Employer manage applications + chat link: `docs/screenshots/employer_manage_applications.png`
- [ ] Messaging thread detail: `docs/screenshots/messaging_thread.png`
- [ ] Feedback submit page: `docs/screenshots/feedback_submit.png`
- [ ] Feedback manage page: `docs/screenshots/feedback_manage.png`
- [ ] Admin dashboard: `docs/screenshots/admin_dashboard.png`
- [ ] Reports page with filters: `docs/screenshots/reports_filters.png`
- [ ] CSV export opened: `docs/screenshots/report_csv_sample.png`
- [ ] PDF export opened: `docs/screenshots/report_pdf_sample.png`
- [ ] Backup utility page: `docs/screenshots/backups_page.png`
- [ ] Notifications center: `docs/screenshots/notifications_center.png`

## Bug References
- No open critical blockers recorded for current Phase 8 sweep.
