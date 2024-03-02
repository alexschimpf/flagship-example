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
    -- Raw private key: 1bb02fb62c08f238442e4a2a9faf9173280775ad322c98d30eeb3fe92bc7f146
    (1, 'gAAAAABl4ujXiEAr28ERd98PGjKuzgQ8mm5kOTJNd2FyMskpb3WRsQkDxW0QIh63hfWWkGTfd5ruP7b98l1X38amEI3zwhEpT3-UZA2-HnvS38gnvk9MtF_tUGW99_XximdMOGz1uJhT4E4PiY8jMCPMlkbQhp8iKuabVXSN4UTZ4_1cMMjYWxE=', 'test');

-- Create "user type" context field
INSERT INTO `context_fields` (`project_id`, `name`, `description`, `field_key`, `value_type`, `enum_def`)
VALUES
	(1, 'user type', 'user type', 'user_type', 5, '{\"normal\":1,\"cool\":2}');

-- Create "COOL_FEATURE" feature flag
INSERT INTO `feature_flags` (`project_id`, `name`, `description`, `conditions`, `enabled`)
VALUES
	(1, 'COOL_FEATURE', 'Enables cool new feature', '[[{\"context_key\":\"user_type\",\"operator\":1,\"value\":2}]]', 1);
