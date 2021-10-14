

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

INSERT INTO public.libraries (id, created_at, title) VALUES ('478fb150-0702-4a34-8b10-28c78f6dc64c', '2021-10-14 16:41:24.175868+03', 'Lib1');


ALTER TABLE public.libraries ENABLE TRIGGER ALL;


ALTER TABLE public.library_openings DISABLE TRIGGER ALL;



ALTER TABLE public.library_openings ENABLE TRIGGER ALL;


ALTER TABLE public.reservations DISABLE TRIGGER ALL;



ALTER TABLE public.reservations ENABLE TRIGGER ALL;


ALTER TABLE public.seat_categories DISABLE TRIGGER ALL;



ALTER TABLE public.seat_categories ENABLE TRIGGER ALL;


ALTER TABLE public.users DISABLE TRIGGER ALL;



ALTER TABLE public.users ENABLE TRIGGER ALL;


