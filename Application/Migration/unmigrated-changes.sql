-- This file is created by the IHP Schema Designer.
-- When you generate a new migration, all changes in this file will be copied into your migration.
-- -- Use http://localhost:8001/NewMigration or `new-migration` to generate a new migration.
-- -- Learn more about migrations: https://ihp.digitallyinduced.com/Guide/database-migrations.html
ALTER TABLE seat_categories ADD COLUMN library_id UUID NOT NULL;
ALTER TABLE seat_categories ADD CONSTRAINT seat_categories_ref_library_id FOREIGN KEY (library_id) REFERENCES libraries (id) ON DELETE NO ACTION;
CREATE INDEX seat_categories_library_id_index ON seat_categories (library_id);