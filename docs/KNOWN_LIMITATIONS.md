# Known Limitations

## Functional
- Advanced weighted/learning recommendation model is not implemented yet.
- Messaging is scoped to application-linked threads only (no general inbox categories).
- Backup restore is documented and manual; automated restore verification is pending.

## Security/Operations
- Login throttling is cache-based and local-instance oriented.
- Sensitive environment values are still local settings for localhost development.
- File naming/storage hardening can be further enhanced for production deployment.

## QA/Delivery
- Screenshot artifacts are listed but may need final capture before viva submission.
- Broader long-run/performance/load testing is not part of current scope.

## Platform Scope
- Project is optimized for localhost (XAMPP + MySQL) and not yet production-hardened.
