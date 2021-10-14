

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;


SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.libraries DISABLE TRIGGER ALL;



ALTER TABLE public.libraries ENABLE TRIGGER ALL;


ALTER TABLE public.library_openings DISABLE TRIGGER ALL;

INSERT INTO public.library_openings (id, created_at, start_time, end_time, library_id) VALUES ('ccb28117-47a5-47cb-91e2-1b063f7f6b5f', '2021-10-14 20:38:41.459073+03', '2021-10-14 21:00:00+03', '2021-10-14 22:00:00+03', 'bc12448d-1438-475a-b1a6-fe85a09fa981');


ALTER TABLE public.library_openings ENABLE TRIGGER ALL;


ALTER TABLE public.reservations DISABLE TRIGGER ALL;

INSERT INTO public.reservations (id, created_at, library_opening_id, seat_number, student_identifier, status) VALUES ('db4545c5-f55d-4f27-840e-43863887e23b', '2021-10-14 22:10:28.173915+03', 'ccb28117-47a5-47cb-91e2-1b063f7f6b5f', 0, '00001', 'rejected');
INSERT INTO public.reservations (id, created_at, library_opening_id, seat_number, student_identifier, status) VALUES ('e562e1a0-fd24-4df7-995b-f2c6dd813dae', '2021-10-14 22:11:02.220184+03', 'ccb28117-47a5-47cb-91e2-1b063f7f6b5f', 0, '12', 'rejected');
INSERT INTO public.reservations (id, created_at, library_opening_id, seat_number, student_identifier, status) VALUES ('c36c107a-be6e-4657-88f5-71ecab7b1473', '2021-10-14 22:11:45.556459+03', 'ccb28117-47a5-47cb-91e2-1b063f7f6b5f', 0, '02', 'accepted');
INSERT INTO public.reservations (id, created_at, library_opening_id, seat_number, student_identifier, status) VALUES ('cb1d9478-21ef-474d-8775-8dfb9638583d', '2021-10-14 22:12:44.653952+03', 'ccb28117-47a5-47cb-91e2-1b063f7f6b5f', 0, '123', 'accepted');
INSERT INTO public.reservations (id, created_at, library_opening_id, seat_number, student_identifier, status) VALUES ('1127a128-7a5f-4f2a-8c36-e64c29856e67', '2021-10-14 22:13:18.530135+03', 'ccb28117-47a5-47cb-91e2-1b063f7f6b5f', 0, '666', 'accepted');


ALTER TABLE public.reservations ENABLE TRIGGER ALL;


ALTER TABLE public.reservation_jobs DISABLE TRIGGER ALL;

INSERT INTO public.reservation_jobs (id, created_at, updated_at, status, last_error, attempts_count, locked_at, locked_by, run_at, reservation_id) VALUES ('0204e2be-f411-4f20-acb6-dd2215d47bee', '2021-10-14 22:10:28.17634+03', '2021-10-14 22:10:28.185659+03', 'job_status_succeeded', NULL, 1, '2021-10-14 22:10:28.180236+03', NULL, '2021-10-14 22:10:28.17634+03', 'db4545c5-f55d-4f27-840e-43863887e23b');
INSERT INTO public.reservation_jobs (id, created_at, updated_at, status, last_error, attempts_count, locked_at, locked_by, run_at, reservation_id) VALUES ('391b3262-b8d1-4699-8ee9-ea005d054026', '2021-10-14 22:11:02.223705+03', '2021-10-14 22:11:02.23523+03', 'job_status_succeeded', NULL, 1, '2021-10-14 22:11:02.228814+03', NULL, '2021-10-14 22:11:02.223705+03', 'e562e1a0-fd24-4df7-995b-f2c6dd813dae');
INSERT INTO public.reservation_jobs (id, created_at, updated_at, status, last_error, attempts_count, locked_at, locked_by, run_at, reservation_id) VALUES ('80c5c847-6bae-4398-b986-9727f36fd336', '2021-10-14 22:11:45.563214+03', '2021-10-14 22:11:45.591801+03', 'job_status_succeeded', NULL, 1, '2021-10-14 22:11:45.574088+03', NULL, '2021-10-14 22:11:45.563214+03', 'c36c107a-be6e-4657-88f5-71ecab7b1473');
INSERT INTO public.reservation_jobs (id, created_at, updated_at, status, last_error, attempts_count, locked_at, locked_by, run_at, reservation_id) VALUES ('3abb7219-7835-4dcd-8963-165f63d3410e', '2021-10-14 22:12:44.658965+03', '2021-10-14 22:12:44.687895+03', 'job_status_succeeded', NULL, 1, '2021-10-14 22:12:44.669985+03', NULL, '2021-10-14 22:12:44.658965+03', 'cb1d9478-21ef-474d-8775-8dfb9638583d');
INSERT INTO public.reservation_jobs (id, created_at, updated_at, status, last_error, attempts_count, locked_at, locked_by, run_at, reservation_id) VALUES ('cb173072-891d-4232-832c-6d0c67c1777d', '2021-10-14 22:13:18.536224+03', '2021-10-14 22:13:18.56806+03', 'job_status_succeeded', NULL, 1, '2021-10-14 22:13:18.547013+03', NULL, '2021-10-14 22:13:18.536224+03', '1127a128-7a5f-4f2a-8c36-e64c29856e67');


ALTER TABLE public.reservation_jobs ENABLE TRIGGER ALL;


ALTER TABLE public.seat_categories DISABLE TRIGGER ALL;



ALTER TABLE public.seat_categories ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;



ALTER TABLE public.users ENABLE TRIGGER ALL;


