--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1 (Ubuntu 11.1-3.pgdg16.04+1)
-- Dumped by pg_dump version 11.4

-- Started on 2019-08-07 18:54:02 CEST

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

--
-- TOC entry 6 (class 2615 OID 2953621)
-- Name: uni1; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA uni1;


ALTER SCHEMA uni1 OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 2953622)
-- Name: academic; Type: TABLE; Schema: uni1; Owner: postgres
--

CREATE TABLE uni1.academic (
    a_id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL,
    "position" integer NOT NULL
);


ALTER TABLE uni1.academic OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 2953630)
-- Name: course; Type: TABLE; Schema: uni1; Owner: postgres
--

CREATE TABLE uni1.course (
    c_id integer NOT NULL,
    title character varying NOT NULL
);


ALTER TABLE uni1.course OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 2953638)
-- Name: course-registration; Type: TABLE; Schema: uni1; Owner: postgres
--

CREATE TABLE uni1."course-registration" (
    c_id integer NOT NULL,
    s_id integer NOT NULL
);


ALTER TABLE uni1."course-registration" OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 2953641)
-- Name: student; Type: TABLE; Schema: uni1; Owner: postgres
--

CREATE TABLE uni1.student (
    s_id integer NOT NULL,
    first_name character varying NOT NULL,
    last_name character varying NOT NULL
);


ALTER TABLE uni1.student OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 2953649)
-- Name: teaching; Type: TABLE; Schema: uni1; Owner: postgres
--

CREATE TABLE uni1.teaching (
    c_id integer NOT NULL,
    a_id integer NOT NULL
);


ALTER TABLE uni1.teaching OWNER TO postgres;

--
-- TOC entry 2906 (class 0 OID 2953622)
-- Dependencies: 197
-- Data for Name: academic; Type: TABLE DATA; Schema: uni1; Owner: postgres
--

COPY uni1.academic (a_id, first_name, last_name, "position") FROM stdin;
1	Anna	Chambers	1
2	Edward	May	9
3	Rachel	Ward	8
4	Priscilla	Hildr	2
5	Zlata	Richmal	3
6	Nathaniel	Abolfazl	4
7	Sergei	Elian	5
8	Alois	Jayant	6
9	Torborg	Chernobog	7
10	Udi	Heinrike	8
11	Alvena	Merry	9
12	Kyler	Josephina	1
13	Gerard	Cosimo	2
14	Karine	Attilio	3
\.


--
-- TOC entry 2907 (class 0 OID 2953630)
-- Dependencies: 198
-- Data for Name: course; Type: TABLE DATA; Schema: uni1; Owner: postgres
--

COPY uni1.course (c_id, title) FROM stdin;
1234	Linear Algebra
1235	Analysis
1236	Operating Systems
1500	Data Mining
1501	Theory of Computing
1502	Research Methods
\.


--
-- TOC entry 2908 (class 0 OID 2953638)
-- Dependencies: 199
-- Data for Name: course-registration; Type: TABLE DATA; Schema: uni1; Owner: postgres
--

COPY uni1."course-registration" (c_id, s_id) FROM stdin;
1234	1
1234	2
1234	3
1235	1
1235	2
1236	1
1236	3
1500	4
1500	5
1501	4
1502	5
1234	1
1234	2
1234	3
1235	1
1235	2
1236	1
1236	3
1500	4
1500	5
1501	4
1502	5
\.


--
-- TOC entry 2909 (class 0 OID 2953641)
-- Dependencies: 200
-- Data for Name: student; Type: TABLE DATA; Schema: uni1; Owner: postgres
--

COPY uni1.student (s_id, first_name, last_name) FROM stdin;
1	Mary	Smith
2	John	Doe
3	Franck	Combs
4	Billy	Hinkley
5	Alison	Robards
\.


--
-- TOC entry 2910 (class 0 OID 2953649)
-- Dependencies: 201
-- Data for Name: teaching; Type: TABLE DATA; Schema: uni1; Owner: postgres
--

COPY uni1.teaching (c_id, a_id) FROM stdin;
1234	1
1234	2
1235	1
1235	3
1236	4
1236	8
1236	9
1500	12
1500	2
1501	12
1501	14
1501	7
1502	13
\.


--
-- TOC entry 2780 (class 2606 OID 2953680)
-- Name: academic academic_pkey; Type: CONSTRAINT; Schema: uni1; Owner: postgres
--

ALTER TABLE ONLY uni1.academic
    ADD CONSTRAINT academic_pkey PRIMARY KEY (a_id);


--
-- TOC entry 2782 (class 2606 OID 2953671)
-- Name: course course_pkey; Type: CONSTRAINT; Schema: uni1; Owner: postgres
--

ALTER TABLE ONLY uni1.course
    ADD CONSTRAINT course_pkey PRIMARY KEY (c_id);


--
-- TOC entry 2784 (class 2606 OID 2953656)
-- Name: student student_pkey; Type: CONSTRAINT; Schema: uni1; Owner: postgres
--

ALTER TABLE ONLY uni1.student
    ADD CONSTRAINT student_pkey PRIMARY KEY (s_id);


-- Completed on 2019-08-07 18:54:08 CEST

--
-- PostgreSQL database dump complete
--

