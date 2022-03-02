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
-- Name: country; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.country AS ENUM (
    'USA',
    'UK',
    'Russia',
    'France',
    'Germany'
);


ALTER TYPE public.country OWNER TO postgres;

--
-- Name: movie_id_numer; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.movie_id_numer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.movie_id_numer OWNER TO postgres;

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
    "Счетчик" numeric NOT NULL,
    CONSTRAINT "Актеры_ДатаРождения_check" CHECK (("ДатаРождения" < CURRENT_DATE)),
    CONSTRAINT "Актеры_ЧислоФильмов_check" CHECK (("ЧислоФильмов" > 5))
);


ALTER TABLE public."Актеры" OWNER TO postgres;

--
-- Name: Связи_Фильмы_Актеры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Связи_Фильмы_Актеры" (
    "Актеры" numeric,
    "Фильмы" numeric
);


ALTER TABLE public."Связи_Фильмы_Актеры" OWNER TO postgres;

--
-- Name: Фильмы; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Фильмы" (
    "Описание" text,
    "Жанры" character varying(200),
    "Год" integer NOT NULL,
    "Бюджет" bigint,
    "Наименование" character varying(40) NOT NULL,
    "Счетчик" numeric NOT NULL,
    movie_id numeric,
    "Страна" public.country DEFAULT 'UK'::public.country,
    CONSTRAINT "Фильмы_Бюджет_check" CHECK (("Бюджет" < 10000)),
    CONSTRAINT "Фильмы_Бюджет_check1" CHECK (("Бюджет" >= 1000)),
    CONSTRAINT "Фильмы_Год_check" CHECK (("Год" > 1900)),
    CONSTRAINT "Фильмы_Год_check1" CHECK (("Год" < 2030))
);


ALTER TABLE public."Фильмы" OWNER TO postgres;

--
-- Name: АктерыВФильмах; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."АктерыВФильмах" AS
 SELECT "Фильмы"."Наименование",
    "Актеры"."Имя",
    "Актеры"."Фамилия"
   FROM public."Фильмы",
    public."Актеры",
    public."Связи_Фильмы_Актеры"
  WHERE (("Связи_Фильмы_Актеры"."Фильмы" = "Фильмы"."Счетчик") AND ("Связи_Фильмы_Актеры"."Актеры" = "Актеры"."Счетчик") AND ("Фильмы"."Год" > 2000));


ALTER TABLE public."АктерыВФильмах" OWNER TO postgres;

--
-- Name: Жанры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Жанры" (
    "Жанр" character varying(50) NOT NULL
);


ALTER TABLE public."Жанры" OWNER TO postgres;

--
-- Name: Режиссёры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Режиссёры" (
    "Фамилия" character varying(50),
    "Имя" character varying(50),
    "ДатаРождения" date,
    "СтранаРождения" character varying(50) DEFAULT 'USA'::character varying NOT NULL,
    "Счетчик" numeric NOT NULL,
    "ЛучшийФильм" numeric,
    CONSTRAINT "Режиссёры_ДатаРождения_check" CHECK (("ДатаРождения" < CURRENT_DATE))
);


ALTER TABLE public."Режиссёры" OWNER TO postgres;

--
-- Name: Связи_Фильмы_Режиссёры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Связи_Фильмы_Режиссёры" (
    "Фильмы" numeric,
    "Режиссёры" numeric
);


ALTER TABLE public."Связи_Фильмы_Режиссёры" OWNER TO postgres;

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
-- Data for Name: Актеры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Актеры" VALUES ('Иванов', 'Александр', '1999-01-03', 'Россия', 10, 1);
INSERT INTO public."Актеры" VALUES ('Александров', 'Никита', '1982-05-03', 'Литва', 6, 3);
INSERT INTO public."Актеры" VALUES ('Пуглов', 'Иван', '1983-07-22', 'Россия', 9, 4);
INSERT INTO public."Актеры" VALUES ('Лейков', 'Илья', '1996-06-12', 'Россия', 11, 5);
INSERT INTO public."Актеры" VALUES ('Коньнова', 'Алия', '1999-04-01', 'Латвия', 7, 6);
INSERT INTO public."Актеры" VALUES ('Коньнов', 'Андрей', '1993-05-04', 'Латвия', 14, 7);


--
-- Data for Name: Жанры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Жанры" VALUES ('Ужасы');
INSERT INTO public."Жанры" VALUES ('Приключение');
INSERT INTO public."Жанры" VALUES ('Драма');
INSERT INTO public."Жанры" VALUES ('Мелодрама');
INSERT INTO public."Жанры" VALUES ('Комедия');
INSERT INTO public."Жанры" VALUES ('Боевик');
INSERT INTO public."Жанры" VALUES ('Романтика');


--
-- Data for Name: Режиссёры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Режиссёры" VALUES ('Пиронов', 'Иван', '1991-05-02', 'Америка', 1, 7);
INSERT INTO public."Режиссёры" VALUES ('Коньнова', 'Анна', '1998-04-02', 'Латвия', 2, 8);
INSERT INTO public."Режиссёры" VALUES ('Иванов', 'Сергей', '1996-01-10', 'Россия', 3, 9);
INSERT INTO public."Режиссёры" VALUES ('Иновиан', 'Олег', '1992-01-16', 'Латвия', 4, 11);
INSERT INTO public."Режиссёры" VALUES ('Каплин', 'Александра', '1992-10-16', 'Америка', 5, 12);
INSERT INTO public."Режиссёры" VALUES ('Куплинов', 'Сергей', '1986-09-27', 'Россия', 6, 13);


--
-- Data for Name: Связи_Фильмы_Актеры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Связи_Фильмы_Актеры" VALUES (1, 7);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (3, 7);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (1, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (1, 9);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (4, 9);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (5, 9);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (5, 10);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (5, 11);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (1, 12);


--
-- Data for Name: Связи_Фильмы_Режиссёры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (13, 2);


--
-- Data for Name: Фильмы; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Фильмы" VALUES ('Фильм про открытие', 'Приключение', 2006, 1900, 'Открытие(2006)', 7, 7, 'UK');
INSERT INTO public."Фильмы" VALUES ('Фильм про закрытие', 'Ужасы', 2010, 8900, 'Закрытие(2010)', 8, 8, 'UK');
INSERT INTO public."Фильмы" VALUES ('Фильм про прилет', 'Романтика', 1999, 7000, 'Прилет(1999)', 9, 9, 'UK');
INSERT INTO public."Фильмы" VALUES ('Фильм про отлет', 'Драма', 2013, 7600, 'Отлет(2013)', 10, 10, 'UK');
INSERT INTO public."Фильмы" VALUES ('Фильм про начало', 'Приключение', 2010, 6000, 'Начало(2010)', 11, 11, 'UK');
INSERT INTO public."Фильмы" VALUES ('Фильм про конец', 'Приключение', 2015, 9000, 'Конец(2015)', 12, 12, 'UK');
INSERT INTO public."Фильмы" VALUES ('Фильм про любовь', 'Романтика', 2000, 7300, 'LOVE', 13, 13, 'USA');


--
-- Name: movie_id_numer; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_id_numer', 13, true);


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

SELECT pg_catalog.setval('public."СчетчикФильмов"', 13, true);


--
-- Name: Актеры Актеры_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Актеры"
    ADD CONSTRAINT "Актеры_pkey" PRIMARY KEY ("Счетчик");


--
-- Name: Жанры Жанры_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Жанры"
    ADD CONSTRAINT "Жанры_pkey" PRIMARY KEY ("Жанр");


--
-- Name: Режиссёры Режиссёры_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Режиссёры"
    ADD CONSTRAINT "Режиссёры_pkey" PRIMARY KEY ("Счетчик");


--
-- Name: Актеры УникальныеПоляАктеров; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Актеры"
    ADD CONSTRAINT "УникальныеПоляАктеров" UNIQUE ("Фамилия", "Имя", "ДатаРождения");


--
-- Name: Фильмы Фильмы_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Фильмы"
    ADD CONSTRAINT "Фильмы_pkey" PRIMARY KEY ("Счетчик");


--
-- Name: Режиссёры Режиссёры_ЛучшийФильм_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Режиссёры"
    ADD CONSTRAINT "Режиссёры_ЛучшийФильм_fkey" FOREIGN KEY ("ЛучшийФильм") REFERENCES public."Фильмы"("Счетчик");


--
-- Name: Связи_Фильмы_Актеры Связи_Актеры_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Связи_Фильмы_Актеры"
    ADD CONSTRAINT "Связи_Актеры_fkey" FOREIGN KEY ("Актеры") REFERENCES public."Актеры"("Счетчик");


--
-- Name: Связи_Фильмы_Актеры Связи_Фильмы_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Связи_Фильмы_Актеры"
    ADD CONSTRAINT "Связи_Фильмы_fkey" FOREIGN KEY ("Фильмы") REFERENCES public."Фильмы"("Счетчик");


--
-- Name: Связи_Фильмы_Режиссёры Связи_Фильмы_Режиссё_Режиссёры_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Связи_Фильмы_Режиссёры"
    ADD CONSTRAINT "Связи_Фильмы_Режиссё_Режиссёры_fkey" FOREIGN KEY ("Режиссёры") REFERENCES public."Режиссёры"("Счетчик");


--
-- Name: Связи_Фильмы_Режиссёры Связи_Фильмы_Режиссёры_Фильмы_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Связи_Фильмы_Режиссёры"
    ADD CONSTRAINT "Связи_Фильмы_Режиссёры_Фильмы_fkey" FOREIGN KEY ("Фильмы") REFERENCES public."Фильмы"("Счетчик");


--
-- Name: Фильмы Фильмы_Жанры_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Фильмы"
    ADD CONSTRAINT "Фильмы_Жанры_fkey" FOREIGN KEY ("Жанры") REFERENCES public."Жанры"("Жанр");


--
-- PostgreSQL database dump complete
--

