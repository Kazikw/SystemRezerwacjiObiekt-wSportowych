--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4
-- Dumped by pg_dump version 17.2

-- Started on 2025-07-09 12:55:16

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: pg_database_owner
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO pg_database_owner;

--
-- TOC entry 4936 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: pg_database_owner
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 869 (class 1247 OID 16575)
-- Name: reservation_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.reservation_status AS ENUM (
    'PENDING',
    'CONFIRMED',
    'ACTIVE',
    'COMPLETED',
    'CANCELED'
);


ALTER TYPE public.reservation_status OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 229 (class 1259 OID 24858)
-- Name: blokady_obiektow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blokady_obiektow (
    id_blokady integer NOT NULL,
    id_obiektu integer NOT NULL,
    data_rozpoczecia date NOT NULL,
    data_zakonczenia date NOT NULL,
    powod_blokady character varying(255) NOT NULL,
    data_utworzenia timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_administratora integer,
    czy_aktywna boolean DEFAULT true
);


ALTER TABLE public.blokady_obiektow OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 24857)
-- Name: blokady_obiektow_id_blokady_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blokady_obiektow_id_blokady_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blokady_obiektow_id_blokady_seq OWNER TO postgres;

--
-- TOC entry 4938 (class 0 OID 0)
-- Dependencies: 228
-- Name: blokady_obiektow_id_blokady_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blokady_obiektow_id_blokady_seq OWNED BY public.blokady_obiektow.id_blokady;


--
-- TOC entry 218 (class 1259 OID 16503)
-- Name: cities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cities (
    id integer NOT NULL,
    name character varying(255) NOT NULL
);


ALTER TABLE public.cities OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16502)
-- Name: cities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cities_id_seq OWNER TO postgres;

--
-- TOC entry 4941 (class 0 OID 0)
-- Dependencies: 217
-- Name: cities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cities_id_seq OWNED BY public.cities.id;


--
-- TOC entry 222 (class 1259 OID 16521)
-- Name: facilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facilities (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    city_id integer NOT NULL
);


ALTER TABLE public.facilities OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16520)
-- Name: facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.facilities_id_seq OWNER TO postgres;

--
-- TOC entry 4943 (class 0 OID 0)
-- Dependencies: 221
-- Name: facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facilities_id_seq OWNED BY public.facilities.id;


--
-- TOC entry 226 (class 1259 OID 24817)
-- Name: friend_relations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.friend_relations (
    id_a integer NOT NULL,
    id_b integer NOT NULL,
    typ_relacji text NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.friend_relations OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 24847)
-- Name: friend_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.friend_relations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.friend_relations_id_seq OWNER TO postgres;

--
-- TOC entry 4945 (class 0 OID 0)
-- Dependencies: 227
-- Name: friend_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.friend_relations_id_seq OWNED BY public.friend_relations.id;


--
-- TOC entry 225 (class 1259 OID 24802)
-- Name: reservation_participants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservation_participants (
    reservation_id integer NOT NULL,
    user_id integer NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.reservation_participants OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 24879)
-- Name: reservation_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservation_participants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservation_participants_id_seq OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 24884)
-- Name: reservation_participants_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.reservation_participants ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reservation_participants_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 16586)
-- Name: reservations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reservations (
    id integer NOT NULL,
    facility_id integer NOT NULL,
    reserver_id integer NOT NULL,
    date date NOT NULL,
    start_time time without time zone NOT NULL,
    end_time time without time zone NOT NULL,
    required_participants integer DEFAULT 10 NOT NULL,
    status character varying DEFAULT 'OCZEKUJACA'::character varying NOT NULL,
    allow_join boolean DEFAULT true
);


ALTER TABLE public.reservations OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16585)
-- Name: reservations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reservations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reservations_id_seq OWNER TO postgres;

--
-- TOC entry 4949 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reservations_id_seq OWNED BY public.reservations.id;


--
-- TOC entry 220 (class 1259 OID 16512)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    first_name character varying(100),
    email character varying(255) NOT NULL,
    password character varying(255),
    role character varying(50)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16511)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 4952 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4737 (class 2604 OID 24861)
-- Name: blokady_obiektow id_blokady; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blokady_obiektow ALTER COLUMN id_blokady SET DEFAULT nextval('public.blokady_obiektow_id_blokady_seq'::regclass);


--
-- TOC entry 4729 (class 2604 OID 16506)
-- Name: cities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities ALTER COLUMN id SET DEFAULT nextval('public.cities_id_seq'::regclass);


--
-- TOC entry 4731 (class 2604 OID 16524)
-- Name: facilities id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facilities ALTER COLUMN id SET DEFAULT nextval('public.facilities_id_seq'::regclass);


--
-- TOC entry 4736 (class 2604 OID 24848)
-- Name: friend_relations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_relations ALTER COLUMN id SET DEFAULT nextval('public.friend_relations_id_seq'::regclass);


--
-- TOC entry 4732 (class 2604 OID 16589)
-- Name: reservations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations ALTER COLUMN id SET DEFAULT nextval('public.reservations_id_seq'::regclass);


--
-- TOC entry 4730 (class 2604 OID 16515)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4928 (class 0 OID 24858)
-- Dependencies: 229
-- Data for Name: blokady_obiektow; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.blokady_obiektow (id_blokady, id_obiektu, data_rozpoczecia, data_zakonczenia, powod_blokady, data_utworzenia, id_administratora, czy_aktywna) VALUES (12, 2, '2025-07-11', '2025-07-13', 'Turniej "puchar Tymbarku"', '2025-06-20 23:03:57.939061', 6, true);
INSERT INTO public.blokady_obiektow (id_blokady, id_obiektu, data_rozpoczecia, data_zakonczenia, powod_blokady, data_utworzenia, id_administratora, czy_aktywna) VALUES (13, 2, '2025-07-17', '2025-07-19', 'Juwenalia', '2025-06-20 23:04:25.764094', 6, true);
INSERT INTO public.blokady_obiektow (id_blokady, id_obiektu, data_rozpoczecia, data_zakonczenia, powod_blokady, data_utworzenia, id_administratora, czy_aktywna) VALUES (14, 1, '2025-09-20', '2025-09-22', 'Wymiana nawierzchni', '2025-06-20 23:05:03.845917', 6, true);
INSERT INTO public.blokady_obiektow (id_blokady, id_obiektu, data_rozpoczecia, data_zakonczenia, powod_blokady, data_utworzenia, id_administratora, czy_aktywna) VALUES (15, 2, '2025-06-09', '2025-06-10', 'Zawody sportowe szkoły średnie', '2025-06-20 23:06:28.943433', 6, true);
INSERT INTO public.blokady_obiektow (id_blokady, id_obiektu, data_rozpoczecia, data_zakonczenia, powod_blokady, data_utworzenia, id_administratora, czy_aktywna) VALUES (16, 1, '2025-07-12', '2025-07-21', 'final test', '2025-07-09 10:49:01.247543', 6, false);


--
-- TOC entry 4917 (class 0 OID 16503)
-- Dependencies: 218
-- Data for Name: cities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cities (id, name) VALUES (1, 'Przeworsk');
INSERT INTO public.cities (id, name) VALUES (2, 'Łańcut');


--
-- TOC entry 4921 (class 0 OID 16521)
-- Dependencies: 222
-- Data for Name: facilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.facilities (id, name, city_id) VALUES (1, 'Orlik', 2);
INSERT INTO public.facilities (id, name, city_id) VALUES (2, 'Stadion', 1);


--
-- TOC entry 4925 (class 0 OID 24817)
-- Dependencies: 226
-- Data for Name: friend_relations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.friend_relations (id_a, id_b, typ_relacji, id) VALUES (6, 2, 'admin-obiekt', 19);
INSERT INTO public.friend_relations (id_a, id_b, typ_relacji, id) VALUES (6, 1, 'admin-obiekt', 20);
INSERT INTO public.friend_relations (id_a, id_b, typ_relacji, id) VALUES (2, 2, 'admin-obiekt', 53);
INSERT INTO public.friend_relations (id_a, id_b, typ_relacji, id) VALUES (2, 7, 'user-user', 54);
INSERT INTO public.friend_relations (id_a, id_b, typ_relacji, id) VALUES (7, 2, 'user-user', 55);
INSERT INTO public.friend_relations (id_a, id_b, typ_relacji, id) VALUES (12, 1, 'admin-obiekt', 59);


--
-- TOC entry 4924 (class 0 OID 24802)
-- Dependencies: 225
-- Data for Name: reservation_participants; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservation_participants (reservation_id, user_id, id) VALUES (192, 7, 57);
INSERT INTO public.reservation_participants (reservation_id, user_id, id) VALUES (191, 7, 55);
INSERT INTO public.reservation_participants (reservation_id, user_id, id) VALUES (192, 2, 56);


--
-- TOC entry 4923 (class 0 OID 16586)
-- Dependencies: 224
-- Data for Name: reservations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reservations (id, facility_id, reserver_id, date, start_time, end_time, required_participants, status, allow_join) VALUES (191, 1, 7, '2025-07-31', '10:00:00', '11:00:00', 1, 'POTWIERDZONA', false);
INSERT INTO public.reservations (id, facility_id, reserver_id, date, start_time, end_time, required_participants, status, allow_join) VALUES (192, 1, 2, '2025-07-31', '15:00:00', '16:00:00', 10, 'POTWIERDZONA', true);


--
-- TOC entry 4919 (class 0 OID 16512)
-- Dependencies: 220
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users (id, first_name, email, password, role) VALUES (1, 'WojtekAdmin', 'wk@gmail.com', '$2a$10$eImiTXuWVxfM37uY4JANjQ==', '$2a$10$admin==');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (3, 'testRegister', 'testRegister', '$2a$10$34AdmiEQ2OFedudP1Wd2WuORFLEDEstakDdQ3YfFAHgxaDPNnUHJy', 'USER');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (4, 'testing', 'testing', '$2a$10$PSQPgGLKXAzw9Q6lXMTj/ed8djh21CylLM4EH8/AvAoqlrOIzjHGO', 'USER');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (6, 'admin', 'admin', '$2a$12$h0JL20..JUTQhc0ckxYn0.WsOezSgIraNLFTGKLWDbPXuDswf4jOi', 'ADMIN');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (9, 'Lemon', 'Lemon@gmail.com', '$2a$10$xyZOCrSy4KWyMOOYN9YRf.sFXDFCiNEXX2rI6cZGTbslqGTD9NSm.', 'USER');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (10, 'rafal', 'rafal@po', '$2a$10$t4GSmsZFsO9bQfB4Zoipwen8Kco9pznrcXh1EOOiqM7JCPqbcTQX.', 'USER');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (2, 'Wojciech Kot', 'user@gmail.com', '$2a$12$upm0t.pEVOZ.yoklSrCYfeijxnG4QwLI5BUj5c4toFICyQRlO57dq', 'USER');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (7, 'user2', 'user2@gmail.com', '$2a$10$QJHJT6zULTCCGz/tOSRgce98dzHqOtAKMqeulJKXIdToBOWlgjo5i', 'USER');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (11, 'daniel', 'daniel@wp.pl', '$2a$10$MDLMHHjkJ8Yn1J/.W86nAuoZIXnSDkE.yTNx8UXJLh01cNCd5QiWO', 'USER');
INSERT INTO public.users (id, first_name, email, password, role) VALUES (12, 'ola', 'ola@ola', '$2a$10$U/rnA3lXtQvUJ.fMnZYVBuQYmj/Qld0M4CHB5y6moPrtGH6pAocAC', 'ADMIN');


--
-- TOC entry 4954 (class 0 OID 0)
-- Dependencies: 228
-- Name: blokady_obiektow_id_blokady_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blokady_obiektow_id_blokady_seq', 16, true);


--
-- TOC entry 4955 (class 0 OID 0)
-- Dependencies: 217
-- Name: cities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cities_id_seq', 1, false);


--
-- TOC entry 4956 (class 0 OID 0)
-- Dependencies: 221
-- Name: facilities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facilities_id_seq', 1, false);


--
-- TOC entry 4957 (class 0 OID 0)
-- Dependencies: 227
-- Name: friend_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.friend_relations_id_seq', 59, true);


--
-- TOC entry 4958 (class 0 OID 0)
-- Dependencies: 230
-- Name: reservation_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_participants_id_seq', 27, false);


--
-- TOC entry 4959 (class 0 OID 0)
-- Dependencies: 231
-- Name: reservation_participants_id_seq1; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservation_participants_id_seq1', 57, true);


--
-- TOC entry 4960 (class 0 OID 0)
-- Dependencies: 223
-- Name: reservations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reservations_id_seq', 192, true);


--
-- TOC entry 4961 (class 0 OID 0)
-- Dependencies: 219
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 12, true);


--
-- TOC entry 4761 (class 2606 OID 24865)
-- Name: blokady_obiektow blokady_obiektow_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blokady_obiektow
    ADD CONSTRAINT blokady_obiektow_pkey PRIMARY KEY (id_blokady);


--
-- TOC entry 4741 (class 2606 OID 16510)
-- Name: cities cities_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_name_key UNIQUE (name);


--
-- TOC entry 4743 (class 2606 OID 16508)
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (id);


--
-- TOC entry 4751 (class 2606 OID 16526)
-- Name: facilities facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facilities
    ADD CONSTRAINT facilities_pkey PRIMARY KEY (id);


--
-- TOC entry 4759 (class 2606 OID 24850)
-- Name: friend_relations friend_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_relations
    ADD CONSTRAINT friend_relations_pkey PRIMARY KEY (id);


--
-- TOC entry 4755 (class 2606 OID 24881)
-- Name: reservation_participants reservation_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_participants
    ADD CONSTRAINT reservation_participants_pkey PRIMARY KEY (id);


--
-- TOC entry 4753 (class 2606 OID 16594)
-- Name: reservations reservations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_pkey PRIMARY KEY (id);


--
-- TOC entry 4745 (class 2606 OID 24878)
-- Name: users uq_first_name; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT uq_first_name UNIQUE (first_name);


--
-- TOC entry 4757 (class 2606 OID 24883)
-- Name: reservation_participants uq_reservation_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_participants
    ADD CONSTRAINT uq_reservation_user UNIQUE (reservation_id, user_id);


--
-- TOC entry 4747 (class 2606 OID 16519)
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- TOC entry 4749 (class 2606 OID 16517)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4769 (class 2606 OID 24871)
-- Name: blokady_obiektow blokady_obiektow_id_administratora_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blokady_obiektow
    ADD CONSTRAINT blokady_obiektow_id_administratora_fkey FOREIGN KEY (id_administratora) REFERENCES public.users(id);


--
-- TOC entry 4770 (class 2606 OID 24866)
-- Name: blokady_obiektow blokady_obiektow_id_obiektu_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blokady_obiektow
    ADD CONSTRAINT blokady_obiektow_id_obiektu_fkey FOREIGN KEY (id_obiektu) REFERENCES public.facilities(id);


--
-- TOC entry 4762 (class 2606 OID 16527)
-- Name: facilities facilities_city_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facilities
    ADD CONSTRAINT facilities_city_id_fkey FOREIGN KEY (city_id) REFERENCES public.cities(id) ON DELETE CASCADE;


--
-- TOC entry 4767 (class 2606 OID 24824)
-- Name: friend_relations friend_relations_id_a_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_relations
    ADD CONSTRAINT friend_relations_id_a_fkey FOREIGN KEY (id_a) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4768 (class 2606 OID 24829)
-- Name: friend_relations friend_relations_id_b_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.friend_relations
    ADD CONSTRAINT friend_relations_id_b_fkey FOREIGN KEY (id_b) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4765 (class 2606 OID 24807)
-- Name: reservation_participants reservation_participants_reservation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_participants
    ADD CONSTRAINT reservation_participants_reservation_id_fkey FOREIGN KEY (reservation_id) REFERENCES public.reservations(id) ON DELETE CASCADE;


--
-- TOC entry 4766 (class 2606 OID 24812)
-- Name: reservation_participants reservation_participants_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservation_participants
    ADD CONSTRAINT reservation_participants_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4763 (class 2606 OID 16595)
-- Name: reservations reservations_facility_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_facility_id_fkey FOREIGN KEY (facility_id) REFERENCES public.facilities(id) ON DELETE CASCADE;


--
-- TOC entry 4764 (class 2606 OID 16600)
-- Name: reservations reservations_reserver_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reservations
    ADD CONSTRAINT reservations_reserver_id_fkey FOREIGN KEY (reserver_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 4937 (class 0 OID 0)
-- Dependencies: 229
-- Name: TABLE blokady_obiektow; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,UPDATE ON TABLE public.blokady_obiektow TO sport_user;


--
-- TOC entry 4939 (class 0 OID 0)
-- Dependencies: 228
-- Name: SEQUENCE blokady_obiektow_id_blokady_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.blokady_obiektow_id_blokady_seq TO sport_user;


--
-- TOC entry 4940 (class 0 OID 0)
-- Dependencies: 218
-- Name: TABLE cities; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.cities TO sport_user;


--
-- TOC entry 4942 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE facilities; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT ON TABLE public.facilities TO sport_user;


--
-- TOC entry 4944 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE friend_relations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,DELETE ON TABLE public.friend_relations TO sport_user;


--
-- TOC entry 4946 (class 0 OID 0)
-- Dependencies: 227
-- Name: SEQUENCE friend_relations_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.friend_relations_id_seq TO sport_user;


--
-- TOC entry 4947 (class 0 OID 0)
-- Dependencies: 225
-- Name: TABLE reservation_participants; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reservation_participants TO sport_user;


--
-- TOC entry 4948 (class 0 OID 0)
-- Dependencies: 224
-- Name: TABLE reservations; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.reservations TO sport_user;


--
-- TOC entry 4950 (class 0 OID 0)
-- Dependencies: 223
-- Name: SEQUENCE reservations_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.reservations_id_seq TO sport_user;


--
-- TOC entry 4951 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE users; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.users TO sport_user;


--
-- TOC entry 4953 (class 0 OID 0)
-- Dependencies: 219
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE public.users_id_seq TO sport_user;


-- Completed on 2025-07-09 12:55:16

--
-- PostgreSQL database dump complete
--

