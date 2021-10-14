

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

INSERT INTO public.libraries (id, created_at, title) VALUES ('bc12448d-1438-475a-b1a6-fe85a09fa981', '2021-10-14 19:55:03.893557+03', 'Lib1');


ALTER TABLE public.libraries ENABLE TRIGGER ALL;


ALTER TABLE public.library_openings DISABLE TRIGGER ALL;

INSERT INTO public.library_openings (id, created_at, start_time, end_time, library_id) VALUES ('ccb28117-47a5-47cb-91e2-1b063f7f6b5f', '2021-10-14 20:38:41.459073+03', '2021-10-14 21:00:00+03', '2021-10-14 22:00:00+03', 'bc12448d-1438-475a-b1a6-fe85a09fa981');


ALTER TABLE public.library_openings ENABLE TRIGGER ALL;


ALTER TABLE public.reservations DISABLE TRIGGER ALL;



ALTER TABLE public.reservations ENABLE TRIGGER ALL;


ALTER TABLE public.reservation_jobs DISABLE TRIGGER ALL;



ALTER TABLE public.reservation_jobs ENABLE TRIGGER ALL;


ALTER TABLE public.seat_categories DISABLE TRIGGER ALL;



ALTER TABLE public.seat_categories ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;



ALTER TABLE public.users ENABLE TRIGGER ALL;


