# ER Relationship Notes

## Primary Entities
- User
- AccountProfile
- UserProfile
- ResumeDocument
- JobPost
- JobApplication
- JobBookmark
- MessageThread
- Message
- Notification
- NotificationPreference
- FeedbackTicket
- DatabaseBackup
- AdminActionLog

## Key Relationships
- User 1:1 AccountProfile
- User 1:1 UserProfile (created on demand)
- User 1:N ResumeDocument
- User (Employer/Alumni) 1:N JobPost via posted_by
- JobPost 1:N JobApplication
- User (Applicant) 1:N JobApplication via applicant
- User N:M JobPost via JobBookmark
- JobApplication 1:1 MessageThread (MVP uniqueness)
- MessageThread 1:N Message
- User 1:N Notification as recipient
- User 1:1 NotificationPreference
- User 1:N FeedbackTicket
- User 1:N DatabaseBackup via created_by
- User 1:N AdminActionLog via admin_user

## Integrity/Constraint Highlights
- JobApplication unique_together(job, applicant) prevents duplicate apply.
- JobBookmark unique_together(user, job) prevents duplicate bookmarks.
- MessageThread OneToOne with JobApplication enforces single conversation per application.
- ResumeDocument validator restricts file type/size.

## Reporting/Audit Relevance
- Reports aggregate from JobPost, JobApplication, AccountProfile.
- AdminActionLog provides traceability of sensitive moderation/backup actions.
