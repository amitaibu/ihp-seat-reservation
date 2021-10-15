-- Your database schema. Use the Schema Designer at http://localhost:8001/ to add some tables.
CREATE TYPE reservation_status AS ENUM ('accepted', 'rejected', 'queued', 'pre_queue');
CREATE TABLE users (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    email TEXT NOT NULL,
    password_hash TEXT NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    failed_login_attempts INT DEFAULT 0 NOT NULL
);
CREATE TABLE libraries (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    title TEXT NOT NULL,
    total_number_of_seats INT NOT NULL
);
CREATE TABLE reservations (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    library_opening_id UUID NOT NULL,
    seat_number INT NOT NULL,
    student_identifier TEXT NOT NULL,
    status reservation_status NOT NULL
);
CREATE TABLE library_openings (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    start_time TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    library_id UUID NOT NULL
);
CREATE TABLE seat_categories (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    title TEXT NOT NULL,
    from_number INT NOT NULL,
    to_number INT NOT NULL,
    library_id UUID NOT NULL
);
CREATE INDEX reservations_library_opening_id_index ON reservations (library_opening_id);
CREATE INDEX library_openings_library_id_index ON library_openings (library_id);
CREATE INDEX seat_categories_library_id_index ON seat_categories (library_id);
CREATE TABLE reservation_jobs (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL,
    status JOB_STATUS DEFAULT 'job_status_not_started' NOT NULL,
    last_error TEXT DEFAULT NULL,
    attempts_count INT DEFAULT 0 NOT NULL,
    locked_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,
    locked_by UUID DEFAULT NULL,
    run_at TIMESTAMP WITH TIME ZONE DEFAULT NOW() NOT NULL
);
ALTER TABLE library_openings ADD CONSTRAINT library_openings_ref_library_id FOREIGN KEY (library_id) REFERENCES libraries (id) ON DELETE NO ACTION;
ALTER TABLE reservations ADD CONSTRAINT reservations_ref_library_opening_id FOREIGN KEY (library_opening_id) REFERENCES library_openings (id) ON DELETE NO ACTION;
ALTER TABLE seat_categories ADD CONSTRAINT seat_categories_ref_library_id FOREIGN KEY (library_id) REFERENCES libraries (id) ON DELETE NO ACTION;
