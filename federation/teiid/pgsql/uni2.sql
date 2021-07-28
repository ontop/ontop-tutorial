--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

-- Started on 2021-04-17 20:35:55 CEST

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 201 (class 1259 OID 16405)
-- Name: course; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.course (
    cid integer NOT NULL,
    lecturer integer NOT NULL,
    lab_teacher integer NOT NULL,
    topic character varying(100) NOT NULL
);

--
-- TOC entry 200 (class 1259 OID 16399)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.person (
    pid integer NOT NULL,
    fname character varying(40) NOT NULL,
    lname character varying(40) NOT NULL,
    status integer NOT NULL
);

--
-- TOC entry 202 (class 1259 OID 16412)
-- Name: registration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.registration (
    pid integer NOT NULL,
    cid integer NOT NULL
);

--
-- TOC entry 3267 (class 0 OID 16405)
-- Dependencies: 201
-- Data for Name: course; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.course (cid, lecturer, lab_teacher, topic) FROM stdin;
1	1	3	Information security
2	8	5	Software factory
3	7	8	Software process management
4	7	9	Introduction to programming
5	1	8	Discrete mathematics and logic
6	7	4	Intelligent Systems
\.


--
-- TOC entry 3266 (class 0 OID 16399)
-- Dependencies: 200
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (pid, fname, lname, status) FROM stdin;
1	Zak	Lane	8
2	Mattie	Moses	1
3	Céline	Mendez	2
4	Rachel	Ward	9
5	Alvena	Merry	3
6	Victor	Scott	7
7	Kellie	Griffin	8
8	Sueann	Samora	9
9	Billy	Hinkley	2
10	Larry	Alfaro	1
11	John	Sims	4
\.


--
-- TOC entry 3268 (class 0 OID 16412)
-- Dependencies: 202
-- Data for Name: registration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.registration (pid, cid) FROM stdin;
2	1
10	4
2	5
10	4
3	2
3	3
9	2
\.


--
-- TOC entry 3129 (class 2606 OID 16409)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (cid);


--
-- TOC entry 3124 (class 2606 OID 16403)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.person
    ADD CONSTRAINT person_pkey PRIMARY KEY (pid);


--
-- TOC entry 3126 (class 1259 OID 16411)
-- Name: course_lab_teacher_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX course_lab_teacher_idx ON public.course USING btree (lab_teacher);


--
-- TOC entry 3127 (class 1259 OID 16410)
-- Name: course_lecturer_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX course_lecturer_idx ON public.course USING btree (lecturer);


--
-- TOC entry 3125 (class 1259 OID 16404)
-- Name: person_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX person_status_idx ON public.person USING btree (status);


--
-- TOC entry 3130 (class 1259 OID 16416)
-- Name: registration_cid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX registration_cid_idx ON public.registration USING btree (cid);


--
-- TOC entry 3131 (class 1259 OID 16415)
-- Name: registration_pid_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX registration_pid_idx ON public.registration USING btree (pid);


--
-- TOC entry 3133 (class 2606 OID 16422)
-- Name: course course_lab_teacher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_lab_teacher_fkey FOREIGN KEY (lab_teacher) REFERENCES public.person(pid);


--
-- TOC entry 3132 (class 2606 OID 16417)
-- Name: course course_lecturer_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.course
    ADD CONSTRAINT course_lecturer_fkey FOREIGN KEY (lecturer) REFERENCES public.person(pid);


--
-- TOC entry 3135 (class 2606 OID 16432)
-- Name: registration registration_cid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registration
    ADD CONSTRAINT registration_cid_fkey FOREIGN KEY (cid) REFERENCES public.course(cid);


--
-- TOC entry 3134 (class 2606 OID 16427)
-- Name: registration registration_pid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.registration
    ADD CONSTRAINT registration_pid_fkey FOREIGN KEY (pid) REFERENCES public.person(pid);


-- Completed on 2021-04-17 20:35:55 CEST

--
-- PostgreSQL database dump complete
--

