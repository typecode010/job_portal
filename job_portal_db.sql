-- Online Job Portal for Alumni Network
-- MySQL schema script (single file)
-- Run this whole script in MySQL Workbench.

CREATE DATABASE IF NOT EXISTS job_portal_db
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE job_portal_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS backup_logs;
DROP TABLE IF EXISTS feedback_tickets;
DROP TABLE IF EXISTS messages;
DROP TABLE IF EXISTS message_thread_participants;
DROP TABLE IF EXISTS message_threads;
DROP TABLE IF EXISTS reports_generated;
DROP TABLE IF EXISTS dispute_tickets;
DROP TABLE IF EXISTS user_activity_logs;
DROP TABLE IF EXISTS admin_action_logs;
DROP TABLE IF EXISTS job_matches;
DROP TABLE IF EXISTS email_notification_logs;
DROP TABLE IF EXISTS notification_preferences;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS application_status_history;
DROP TABLE IF EXISTS job_applications;
DROP TABLE IF EXISTS job_bookmarks;
DROP TABLE IF EXISTS job_skills;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS employer_profiles;
DROP TABLE IF EXISTS resume_documents;
DROP TABLE IF EXISTS user_skills;
DROP TABLE IF EXISTS skills;
DROP TABLE IF EXISTS experience_details;
DROP TABLE IF EXISTS education_details;
DROP TABLE IF EXISTS user_profiles;
DROP TABLE IF EXISTS password_reset_tokens;
DROP TABLE IF EXISTS email_verification_tokens;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS roles;

SET FOREIGN_KEY_CHECKS = 1;

-- -------------------------------------
-- 1) Roles and Users
-- -------------------------------------

CREATE TABLE roles (
  role_id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_name VARCHAR(30) NOT NULL,
  description VARCHAR(255) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_roles_role_name (role_name)
) ENGINE=InnoDB;

INSERT INTO roles (role_name, description)
VALUES
  ('student', 'Current student user'),
  ('alumni', 'Alumni user'),
  ('employer', 'Employer or recruiter user'),
  ('admin', 'System administrator')
ON DUPLICATE KEY UPDATE
  description = VALUES(description);

CREATE TABLE users (
  user_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  role_id TINYINT UNSIGNED NOT NULL,
  first_name VARCHAR(100) NOT NULL,
  last_name VARCHAR(100) NOT NULL,
  email VARCHAR(255) NOT NULL,
  password_hash VARCHAR(255) NOT NULL,
  phone VARCHAR(30) NULL,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  is_email_verified TINYINT(1) NOT NULL DEFAULT 0,
  approval_status ENUM('pending', 'approved', 'rejected', 'suspended') NOT NULL DEFAULT 'pending',
  last_login_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_users_email (email),
  KEY idx_users_role_id (role_id),
  KEY idx_users_approval_status (approval_status),
  CONSTRAINT fk_users_role
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE email_verification_tokens (
  token_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  token VARCHAR(128) NOT NULL,
  expires_at DATETIME NOT NULL,
  used_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_email_verification_token (token),
  KEY idx_email_verification_user_id (user_id),
  CONSTRAINT fk_email_verification_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE password_reset_tokens (
  token_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  token VARCHAR(128) NOT NULL,
  expires_at DATETIME NOT NULL,
  used_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_password_reset_token (token),
  KEY idx_password_reset_user_id (user_id),
  CONSTRAINT fk_password_reset_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------
-- 2) Profile, Education, Experience, Skills, Resumes
-- -------------------------------------

CREATE TABLE user_profiles (
  profile_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  headline VARCHAR(200) NULL,
  about_me TEXT NULL,
  contact_email VARCHAR(255) NULL,
  contact_phone VARCHAR(30) NULL,
  date_of_birth DATE NULL,
  city VARCHAR(100) NULL,
  state VARCHAR(100) NULL,
  country VARCHAR(100) NULL,
  linkedin_url VARCHAR(255) NULL,
  github_url VARCHAR(255) NULL,
  portfolio_url VARCHAR(255) NULL,
  graduation_year SMALLINT UNSIGNED NULL,
  department VARCHAR(150) NULL,
  current_company VARCHAR(150) NULL,
  current_position VARCHAR(150) NULL,
  total_experience_years DECIMAL(4,1) NULL,
  visibility ENUM('public', 'private') NOT NULL DEFAULT 'public',
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_user_profiles_user_id (user_id),
  KEY idx_user_profiles_visibility (visibility),
  CONSTRAINT fk_user_profiles_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE education_details (
  education_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  institute_name VARCHAR(200) NOT NULL,
  degree_name VARCHAR(150) NOT NULL,
  field_of_study VARCHAR(150) NULL,
  start_year SMALLINT UNSIGNED NULL,
  end_year SMALLINT UNSIGNED NULL,
  grade_or_cgpa VARCHAR(30) NULL,
  description TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_education_user_id (user_id),
  CONSTRAINT fk_education_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE experience_details (
  experience_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  company_name VARCHAR(200) NOT NULL,
  job_title VARCHAR(150) NOT NULL,
  employment_type VARCHAR(100) NULL,
  start_date DATE NULL,
  end_date DATE NULL,
  is_current_job TINYINT(1) NOT NULL DEFAULT 0,
  location VARCHAR(150) NULL,
  description TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_experience_user_id (user_id),
  CONSTRAINT fk_experience_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE skills (
  skill_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  skill_name VARCHAR(100) NOT NULL,
  skill_category VARCHAR(100) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_skills_skill_name (skill_name)
) ENGINE=InnoDB;

CREATE TABLE user_skills (
  user_skill_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  skill_id INT UNSIGNED NOT NULL,
  skill_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL DEFAULT 'beginner',
  years_of_experience DECIMAL(4,1) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_user_skill (user_id, skill_id),
  KEY idx_user_skills_skill_id (skill_id),
  CONSTRAINT fk_user_skills_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_user_skills_skill
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE resume_documents (
  resume_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  file_name VARCHAR(255) NOT NULL,
  file_path VARCHAR(500) NOT NULL,
  mime_type VARCHAR(100) NOT NULL DEFAULT 'application/pdf',
  file_size_kb INT UNSIGNED NULL,
  is_primary TINYINT(1) NOT NULL DEFAULT 1,
  is_active TINYINT(1) NOT NULL DEFAULT 1,
  uploaded_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_resume_user_id (user_id),
  CONSTRAINT fk_resume_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE employer_profiles (
  employer_profile_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  company_name VARCHAR(200) NOT NULL,
  website_url VARCHAR(255) NULL,
  industry VARCHAR(100) NULL,
  company_size VARCHAR(50) NULL,
  headquarters VARCHAR(150) NULL,
  company_description TEXT NULL,
  is_verified TINYINT(1) NOT NULL DEFAULT 0,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_employer_profiles_user_id (user_id),
  CONSTRAINT fk_employer_profile_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------
-- 3) Jobs and Applications
-- -------------------------------------

CREATE TABLE jobs (
  job_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  posted_by_user_id BIGINT UNSIGNED NULL,
  posted_by_type ENUM('alumni', 'employer', 'admin') NOT NULL,
  title VARCHAR(200) NOT NULL,
  description TEXT NOT NULL,
  location_city VARCHAR(100) NULL,
  location_state VARCHAR(100) NULL,
  location_country VARCHAR(100) NULL,
  is_remote TINYINT(1) NOT NULL DEFAULT 0,
  job_type ENUM('full_time', 'part_time', 'internship', 'contract') NOT NULL DEFAULT 'full_time',
  experience_min_years DECIMAL(4,1) NULL,
  experience_max_years DECIMAL(4,1) NULL,
  salary_min DECIMAL(12,2) NULL,
  salary_max DECIMAL(12,2) NULL,
  currency_code CHAR(3) NOT NULL DEFAULT 'USD',
  required_qualification VARCHAR(255) NULL,
  application_deadline DATE NULL,
  status ENUM('pending', 'approved', 'rejected', 'open', 'closed') NOT NULL DEFAULT 'pending',
  rejection_reason TEXT NULL,
  approved_by_user_id BIGINT UNSIGNED NULL,
  approved_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_jobs_posted_by (posted_by_user_id),
  KEY idx_jobs_status (status),
  KEY idx_jobs_deadline (application_deadline),
  KEY idx_jobs_job_type (job_type),
  KEY idx_jobs_city (location_city),
  CONSTRAINT fk_jobs_posted_by_user
    FOREIGN KEY (posted_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_jobs_approved_by_user
    FOREIGN KEY (approved_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE job_skills (
  job_skill_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  job_id BIGINT UNSIGNED NOT NULL,
  skill_id INT UNSIGNED NOT NULL,
  required_level ENUM('beginner', 'intermediate', 'advanced') NOT NULL DEFAULT 'beginner',
  weight TINYINT UNSIGNED NOT NULL DEFAULT 5,
  UNIQUE KEY uq_job_skill (job_id, skill_id),
  KEY idx_job_skills_skill_id (skill_id),
  CONSTRAINT fk_job_skills_job
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_job_skills_skill
    FOREIGN KEY (skill_id) REFERENCES skills(skill_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE=InnoDB;

CREATE TABLE job_bookmarks (
  bookmark_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  job_id BIGINT UNSIGNED NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_job_bookmark (user_id, job_id),
  KEY idx_job_bookmarks_job_id (job_id),
  CONSTRAINT fk_job_bookmarks_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_job_bookmarks_job
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE job_applications (
  application_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  job_id BIGINT UNSIGNED NOT NULL,
  applicant_user_id BIGINT UNSIGNED NOT NULL,
  resume_id BIGINT UNSIGNED NULL,
  cover_letter TEXT NULL,
  current_status ENUM('applied', 'shortlisted', 'interview_scheduled', 'selected', 'rejected', 'withdrawn') NOT NULL DEFAULT 'applied',
  applied_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_job_applications_unique (job_id, applicant_user_id),
  KEY idx_job_applications_applicant (applicant_user_id),
  KEY idx_job_applications_status (current_status),
  CONSTRAINT fk_job_applications_job
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_job_applications_user
    FOREIGN KEY (applicant_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_job_applications_resume
    FOREIGN KEY (resume_id) REFERENCES resume_documents(resume_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE application_status_history (
  status_history_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  application_id BIGINT UNSIGNED NOT NULL,
  old_status ENUM('applied', 'shortlisted', 'interview_scheduled', 'selected', 'rejected', 'withdrawn') NULL,
  new_status ENUM('applied', 'shortlisted', 'interview_scheduled', 'selected', 'rejected', 'withdrawn') NOT NULL,
  changed_by_user_id BIGINT UNSIGNED NULL,
  remarks VARCHAR(500) NULL,
  changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_application_status_application_id (application_id),
  KEY idx_application_status_changed_by (changed_by_user_id),
  CONSTRAINT fk_application_status_application
    FOREIGN KEY (application_id) REFERENCES job_applications(application_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_application_status_changed_by
    FOREIGN KEY (changed_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------
-- 4) Matching, Notifications, Activity
-- -------------------------------------

CREATE TABLE job_matches (
  match_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  job_id BIGINT UNSIGNED NOT NULL,
  match_score DECIMAL(5,2) NOT NULL,
  match_level ENUM('low', 'moderate', 'strong') NOT NULL,
  match_reason VARCHAR(500) NULL,
  computed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_job_matches_user_job (user_id, job_id),
  KEY idx_job_matches_score (match_score),
  CONSTRAINT fk_job_matches_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_job_matches_job
    FOREIGN KEY (job_id) REFERENCES jobs(job_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE notifications (
  notification_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  recipient_user_id BIGINT UNSIGNED NOT NULL,
  notification_type ENUM('job_posted', 'application_update', 'new_match', 'system_alert', 'message', 'admin_alert') NOT NULL,
  title VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  related_entity_type VARCHAR(50) NULL,
  related_entity_id BIGINT UNSIGNED NULL,
  is_read TINYINT(1) NOT NULL DEFAULT 0,
  read_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_notifications_recipient_read (recipient_user_id, is_read),
  KEY idx_notifications_type (notification_type),
  CONSTRAINT fk_notifications_recipient
    FOREIGN KEY (recipient_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE notification_preferences (
  preference_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  email_new_jobs TINYINT(1) NOT NULL DEFAULT 1,
  email_application_updates TINYINT(1) NOT NULL DEFAULT 1,
  email_admin_alerts TINYINT(1) NOT NULL DEFAULT 1,
  inapp_new_jobs TINYINT(1) NOT NULL DEFAULT 1,
  inapp_application_updates TINYINT(1) NOT NULL DEFAULT 1,
  inapp_messages TINYINT(1) NOT NULL DEFAULT 1,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY uq_notification_preferences_user_id (user_id),
  CONSTRAINT fk_notification_preferences_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE email_notification_logs (
  email_log_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  notification_id BIGINT UNSIGNED NULL,
  user_id BIGINT UNSIGNED NULL,
  email_to VARCHAR(255) NOT NULL,
  subject VARCHAR(255) NOT NULL,
  body_preview VARCHAR(500) NULL,
  send_status ENUM('queued', 'sent', 'failed') NOT NULL DEFAULT 'queued',
  error_message VARCHAR(500) NULL,
  sent_at DATETIME NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_email_log_status (send_status),
  KEY idx_email_log_user_id (user_id),
  CONSTRAINT fk_email_log_notification
    FOREIGN KEY (notification_id) REFERENCES notifications(notification_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_email_log_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE user_activity_logs (
  activity_log_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NULL,
  activity_type VARCHAR(100) NOT NULL,
  activity_description VARCHAR(500) NULL,
  ip_address VARCHAR(45) NULL,
  user_agent VARCHAR(255) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_activity_user_id (user_id),
  KEY idx_activity_type (activity_type),
  CONSTRAINT fk_activity_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------
-- 5) Admin, Reporting, Disputes
-- -------------------------------------

CREATE TABLE admin_action_logs (
  admin_action_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  admin_user_id BIGINT UNSIGNED NULL,
  action_type VARCHAR(100) NOT NULL,
  target_table VARCHAR(100) NOT NULL,
  target_id BIGINT UNSIGNED NULL,
  action_note TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_admin_action_admin_user (admin_user_id),
  KEY idx_admin_action_type (action_type),
  CONSTRAINT fk_admin_action_admin_user
    FOREIGN KEY (admin_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE dispute_tickets (
  dispute_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  raised_by_user_id BIGINT UNSIGNED NOT NULL,
  against_user_id BIGINT UNSIGNED NULL,
  related_job_id BIGINT UNSIGNED NULL,
  related_application_id BIGINT UNSIGNED NULL,
  subject VARCHAR(200) NOT NULL,
  description TEXT NOT NULL,
  status ENUM('open', 'in_review', 'resolved', 'closed') NOT NULL DEFAULT 'open',
  resolution_note TEXT NULL,
  resolved_by_user_id BIGINT UNSIGNED NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_dispute_raised_by (raised_by_user_id),
  KEY idx_dispute_status (status),
  CONSTRAINT fk_dispute_raised_by
    FOREIGN KEY (raised_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_dispute_against_user
    FOREIGN KEY (against_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_dispute_job
    FOREIGN KEY (related_job_id) REFERENCES jobs(job_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_dispute_application
    FOREIGN KEY (related_application_id) REFERENCES job_applications(application_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_dispute_resolved_by
    FOREIGN KEY (resolved_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE reports_generated (
  report_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  generated_by_user_id BIGINT UNSIGNED NULL,
  report_name VARCHAR(150) NOT NULL,
  report_format ENUM('csv', 'pdf') NOT NULL,
  filters_json JSON NULL,
  file_path VARCHAR(500) NULL,
  generated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_reports_generated_by (generated_by_user_id),
  KEY idx_reports_format (report_format),
  CONSTRAINT fk_reports_generated_by
    FOREIGN KEY (generated_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- -------------------------------------
-- 6) Optional: Messaging and Feedback
-- -------------------------------------

CREATE TABLE message_threads (
  thread_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  subject VARCHAR(200) NULL,
  created_by_user_id BIGINT UNSIGNED NULL,
  related_job_id BIGINT UNSIGNED NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_threads_created_by (created_by_user_id),
  CONSTRAINT fk_threads_created_by
    FOREIGN KEY (created_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL,
  CONSTRAINT fk_threads_related_job
    FOREIGN KEY (related_job_id) REFERENCES jobs(job_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE message_thread_participants (
  participant_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  thread_id BIGINT UNSIGNED NOT NULL,
  user_id BIGINT UNSIGNED NOT NULL,
  last_read_at DATETIME NULL,
  joined_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY uq_thread_participant (thread_id, user_id),
  KEY idx_thread_participants_user_id (user_id),
  CONSTRAINT fk_thread_participants_thread
    FOREIGN KEY (thread_id) REFERENCES message_threads(thread_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_thread_participants_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE messages (
  message_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  thread_id BIGINT UNSIGNED NOT NULL,
  sender_user_id BIGINT UNSIGNED NULL,
  message_body TEXT NOT NULL,
  is_deleted TINYINT(1) NOT NULL DEFAULT 0,
  sent_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_messages_thread_sent (thread_id, sent_at),
  CONSTRAINT fk_messages_thread
    FOREIGN KEY (thread_id) REFERENCES message_threads(thread_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT fk_messages_sender
    FOREIGN KEY (sender_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

CREATE TABLE feedback_tickets (
  feedback_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id BIGINT UNSIGNED NOT NULL,
  category ENUM('bug', 'feature_request', 'general', 'abuse_report') NOT NULL DEFAULT 'general',
  subject VARCHAR(200) NOT NULL,
  message TEXT NOT NULL,
  status ENUM('open', 'in_progress', 'resolved', 'closed') NOT NULL DEFAULT 'open',
  admin_response TEXT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY idx_feedback_user_id (user_id),
  KEY idx_feedback_status (status),
  CONSTRAINT fk_feedback_user
    FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------
-- 7) Optional: Backup Log
-- -------------------------------------

CREATE TABLE backup_logs (
  backup_id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  initiated_by_user_id BIGINT UNSIGNED NULL,
  backup_type ENUM('full', 'incremental') NOT NULL DEFAULT 'full',
  backup_file_path VARCHAR(500) NULL,
  status ENUM('started', 'completed', 'failed') NOT NULL DEFAULT 'started',
  started_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  completed_at DATETIME NULL,
  notes VARCHAR(500) NULL,
  created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  KEY idx_backup_initiated_by (initiated_by_user_id),
  KEY idx_backup_status (status),
  CONSTRAINT fk_backup_initiated_by
    FOREIGN KEY (initiated_by_user_id) REFERENCES users(user_id)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB;

-- End of schema
