# Release Readiness Checklist (Viva Freeze)

## Core Functional Readiness
- [x] Multi-role authentication and authorization
- [x] Profile and resume management
- [x] Job posting, search/filtering, apply flow
- [x] Application status management
- [x] Notifications (in-app + email backend flow)
- [x] Admin moderation for users and jobs
- [x] Reports with CSV/PDF export

## Optional Feature Readiness
- [x] Internal messaging (application participant scope)
- [x] Feedback/issue reporting workflow
- [x] Backup utility MVP with admin controls
- [x] Security hardening MVP (throttling + audit logs)
- [ ] Advanced weighted matching model

## QA Gate
- [x] Django system check clean
- [x] Automated tests passing in current suite
- [x] Required Phase 8 integration tests added
- [x] Manual QA evidence document prepared
- [ ] Final screenshot pack captured

## Ops/Recovery
- [x] Backup path defined and documented
- [x] Restore command example documented
- [ ] Automated backup/restore validation script

## Viva Package
- [x] Architecture summary
- [x] ER relationship notes
- [x] Matching logic notes
- [x] Known limitations
- [x] Test evidence matrix
- [ ] Final slide deck and demo script (external deliverables)

## Report Sample References
- CSV endpoint: /job_portal/reports/export/csv/
- PDF endpoint: /job_portal/reports/export/pdf/
- Suggested capture placeholders:
  - docs/screenshots/report_csv_sample.png
  - docs/screenshots/report_pdf_sample.png

## Backup/Restore Notes
- Backup create/list/download: /job_portal/reports/backups/
- Default backup storage: backups/
- Manual restore command example is documented in README and operations notes.
