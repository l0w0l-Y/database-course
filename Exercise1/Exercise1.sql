--
-- PostgreSQL database dump
--

-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.4

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Актеры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Актеры" (
    "Фамилия" character varying(50),
    "Имя" character varying(50),
    "ДатаРождения" date,
    "СтранаРождения" character varying(50),
    "ЧислоФильмов" smallint,
    "Счетчик" numeric,
    CONSTRAINT "Актеры_ЧислоФильмов_check" CHECK (("ЧислоФильмов" > 5))
);


ALTER TABLE public."Актеры" OWNER TO postgres;

--
-- Name: Режиссёры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Режиссёры" (
    "Фамилия" character varying(50),
    "Имя" character varying(50),
    "ДатаРождения" date,
    "СтранаРождения" character varying(50) DEFAULT 'USA'::character varying NOT NULL,
    "Счетчик" numeric
);


ALTER TABLE public."Режиссёры" OWNER TO postgres;

--
-- Name: СчетчикАктеры; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."СчетчикАктеры"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."СчетчикАктеры" OWNER TO postgres;

--
-- Name: СчетчикРежиссёры; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."СчетчикРежиссёры"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."СчетчикРежиссёры" OWNER TO postgres;

--
-- Name: СчетчикФильмов; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."СчетчикФильмов"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."СчетчикФильмов" OWNER TO postgres;

--
-- Name: Фильмы; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Фильмы" (
    "Описание" text,
    "Жанры" character varying(200),
    "Страна" character varying(30),
    "Год" integer NOT NULL,
    "Бюджет" bigint,
    "Наименование" character varying(40) NOT NULL,
    "Счетчик" "char",
    CONSTRAINT "Фильмы_Бюджет_check" CHECK (("Бюджет" < 10000)),
    CONSTRAINT "Фильмы_Год_check" CHECK (("Год" > 1900)),
    CONSTRAINT "Фильмы_Год_check1" CHECK (("Год" < 2030))
);


ALTER TABLE public."Фильмы" OWNER TO postgres;

--
-- Data for Name: Актеры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Актеры" VALUES ('Иванов', 'Александр', '1999-01-03', 'Россия', 10, 1);
INSERT INTO public."Актеры" VALUES ('Александров', 'Никита', '1982-05-03', 'Литва', 6, 3);
INSERT INTO public."Актеры" VALUES ('Пуглов', 'Иван', '1983-07-22', 'Россия', 9, 4);
INSERT INTO public."Актеры" VALUES ('Лейков', 'Илья', '1996-06-12', 'Россия', 11, 5);
INSERT INTO public."Актеры" VALUES ('Коньнова', 'Алия', '1999-04-01', 'Латвия', 7, 6);
INSERT INTO public."Актеры" VALUES ('Коньнов', 'Андрей', '1993-05-04', 'Латвия', 14, 7);


--
-- Data for Name: Режиссёры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Режиссёры" VALUES ('Пиронов', 'Иван', '1991-05-02', 'Америка', 1);
INSERT INTO public."Режиссёры" VALUES ('Коньнова', 'Анна', '1998-04-02', 'Латвия', 2);
INSERT INTO public."Режиссёры" VALUES ('Иванов', 'Сергей', '1996-01-10', 'Россия', 3);
INSERT INTO public."Режиссёры" VALUES ('Иновиан', 'Олег', '1992-01-16', 'Латвия', 4);
INSERT INTO public."Режиссёры" VALUES ('Каплин', 'Александра', '1992-10-16', 'Америка', 5);
INSERT INTO public."Режиссёры" VALUES ('Куплинов', 'Сергей', '1986-09-27', 'Россия', 6);


--
-- Data for Name: Фильмы; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Фильмы" VALUES ('Фильм про открытие', 'Приключение', 'Россия', 2006, 1900, 'Открытие', '1');
INSERT INTO public."Фильмы" VALUES ('Фильм про закрытие', 'Ужасы', 'Россия', 2010, 8900, 'Закрытие', '2');
INSERT INTO public."Фильмы" VALUES ('Фильм про прилет', 'Романтика', 'Россия', 2011, 7000, 'Прилет', '3');
INSERT INTO public."Фильмы" VALUES ('Фильм про отлет', 'Драма', 'Россия', 2013, 7600, 'Отлет', '4');
INSERT INTO public."Фильмы" VALUES ('Фильм про начало', 'Приключение', 'Америка', 2010, 6000, 'Начало', '5');
INSERT INTO public."Фильмы" VALUES ('Фильм про конец', 'Приключение', 'Америка', 2015, 9000, 'Конец', '6');


--
-- Name: СчетчикАктеры; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СчетчикАктеры"', 7, true);


--
-- Name: СчетчикРежиссёры; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СчетчикРежиссёры"', 6, true);


--
-- Name: СчетчикФильмов; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СчетчикФильмов"', 6, true);


--
-- Name: Актеры УникальныеПоляАктеров; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Актеры"
    ADD CONSTRAINT "УникальныеПоляАктеров" UNIQUE ("Фамилия", "Имя", "ДатаРождения");


--
-- PostgreSQL database dump complete
--

