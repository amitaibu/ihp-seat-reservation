-- This file is created by the IHP Schema Designer.
-- When you generate a new migration, all changes in this file will be copied into your migration.
-- -- Use http://localhost:8001/NewMigration or `new-migration` to generate a new migration.
-- -- Learn more about migrations: https://ihp.digitallyinduced.com/Guide/database-migrations.html
ALTER TABLE seat_categories ADD COLUMN library_id UUID NOT NULL;
ALTER TABLE seat_categories ADD CONSTRAINT seat_categories_ref_library_id FOREIGN KEY (library_id) REFERENCES libraries (id) ON DELETE NO ACTION;
CREATE INDEX seat_categories_library_id_index ON seat_categories (library_id);
ALTER TABLE reservation_jobs ADD COLUMN reservation_id UUID NOT NULL;
ALTER TABLE reservation_jobs ADD CONSTRAINT reservation_jobs_ref_reservation_id FOREIGN KEY (reservation_id) REFERENCES reservations (id) ON DELETE NO ACTION;
CREATE INDEX reservation_jobs_reservation_id_index ON reservation_jobs (reservation_id);
ALTER TABLE reservations ADD COLUMN status reservation_status NOT NULL;
ALTER TABLE libraries ADD COLUMN total_number_of_seats INT NOT NULL;
