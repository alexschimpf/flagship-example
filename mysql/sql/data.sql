-- Create initial owner user
-- Password: Test123!
INSERT INTO flagship.users (email, name, role, status, password)
VALUES
('owner@flag.ship', 'Flagship Owner', 20, 2, '$2a$12$Qwux2dsu.moP5dLszwxJ5uWbPy59UY1PPnoraat/lFh35ZbpZ7SLq');

-- Create project named "Example Project"
INSERT INTO `projects` (`name`, `created_date`, `updated_date`)
VALUES
	('Example Project', '2024-01-09 01:21:46', '2024-01-09 01:21:46');

-- Assign user to project
INSERT INTO flagship.users_projects (user_id, project_id)
VALUES
    (1, 1);

-- Create a private key for the project
INSERT INTO `project_private_keys` (`project_id`, `private_key`, `name`)
VALUES
    -- Raw private key: 754a019a9f7c4a832ceaf2c83f50d40dffc1e018ac6635129f1ed5c1b5f18901
    (1, 'gAAAAABl4Su9hcmX8Jt0dj0IplZ23WPSUvwjQrJD7Gd3EpdptSsCYBCxXP3iZSDizdoyO5mWtPGDkSY_qKs80-F7WCJwv1mpHI5pFxjn9EqQFj1hP6Ym6M5v7YqVResL4WDQ6iPARzpeKE62wbKdle03Yek4v5uZVjjFxY-n9miJGkC36KvLWPY=', 'test');

-- Create "user type" context field
INSERT INTO `context_fields` (`project_id`, `name`, `description`, `field_key`, `value_type`, `enum_def`)
VALUES
	(1, 'user type', 'user type', 'user_type', 5, '{\"normal\":1,\"cool\":2}');

-- Create "COOL_FEATURE" feature flag
INSERT INTO `feature_flags` (`project_id`, `name`, `description`, `conditions`, `enabled`)
VALUES
	(1, 'COOL_FEATURE', 'Enables cool new feature', '[[{\"context_key\":\"user_type\",\"operator\":1,\"value\":2}]]', 1);

