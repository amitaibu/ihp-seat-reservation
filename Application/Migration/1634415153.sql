-- Write your SQL migration code in here
-- This file is created by the IHP Schema Designer.
-- When you generate a new migration, all changes in this file will be copied into your migration.
-- -- Use http://localhost:8001/NewMigration or `new-migration` to generate a new migration.
-- -- Learn more about migrations: https://ihp.digitallyinduced.com/Guide/database-migrations.html
ALTER TABLE reservation_jobs DROP CONSTRAINT;
ALTER TABLE reservation_jobs ADD CONSTRAINT reservation_jobs_ref_reservation_id FOREIGN KEY (reservation_id) REFERENCES reservations (id) ON DELETE CASCADE;