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
-- Name: Связи_Фильмы_Режиссёры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Связи_Фильмы_Режиссёры" (
    "Фильмы" numeric,
    "Режиссёры" numeric
);


ALTER TABLE public."Связи_Фильмы_Режиссёры" OWNER TO postgres;

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
    "Оценка" numeric,
    "Продолжительность" numeric,
    CONSTRAINT "Фильмы_Бюджет_check" CHECK (("Бюджет" < 10000)),
    CONSTRAINT "Фильмы_Бюджет_check1" CHECK (("Бюджет" >= 1000)),
    CONSTRAINT "Фильмы_Год_check" CHECK (("Год" > 1900)),
    CONSTRAINT "Фильмы_Год_check1" CHECK (("Год" < 2030))
);


ALTER TABLE public."Фильмы" OWNER TO postgres;

--
-- Name: task11in4list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.task11in4list AS
 SELECT "Связи_Фильмы_Режиссёры"."Режиссёры"
   FROM public."Связи_Фильмы_Режиссёры"
  WHERE ("Связи_Фильмы_Режиссёры"."Фильмы" IN ( SELECT "Фильмы".movie_id
           FROM public."Фильмы"
          WHERE (("Фильмы"."Бюджет" > ( SELECT min("Фильмы_1"."Бюджет") AS min
                   FROM public."Фильмы" "Фильмы_1"
                  WHERE ("Фильмы_1"."Год" = 2015))) OR ("Фильмы"."Бюджет" < ( SELECT max("Фильмы_1"."Бюджет") AS max
                   FROM public."Фильмы" "Фильмы_1"
                  WHERE ("Фильмы_1"."Год" = 2016))))));


ALTER TABLE public.task11in4list OWNER TO postgres;

--
-- Name: task12in4list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.task12in4list AS
 SELECT "Связи_Фильмы_Режиссёры"."Режиссёры"
   FROM public."Связи_Фильмы_Режиссёры"
  WHERE ("Связи_Фильмы_Режиссёры"."Фильмы" IN ( SELECT "Фильмы"."Счетчик"
           FROM public."Фильмы"
          WHERE ("Фильмы"."Год" < 2000)))
UNION ALL
 SELECT "Номер_Режиссёра"."Режиссёры"
   FROM ( SELECT count(*) AS count,
            "Связи_Фильмы_Режиссёры"."Режиссёры"
           FROM public."Связи_Фильмы_Режиссёры"
          GROUP BY "Связи_Фильмы_Режиссёры"."Режиссёры"
         HAVING (count(*) > 10)) "Номер_Режиссёра";


ALTER TABLE public.task12in4list OWNER TO postgres;

--
-- Name: task7in4list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.task7in4list AS
 SELECT avg("Фильмы"."Бюджет") AS avg
   FROM public."Фильмы"
  WHERE ("Фильмы"."Год" < 2000)
UNION
 SELECT avg("Фильмы"."Бюджет") AS avg
   FROM public."Фильмы"
  WHERE (("Фильмы"."Год" >= 2000) AND ("Фильмы"."Год" < 2005))
UNION
 SELECT avg("Фильмы"."Бюджет") AS avg
   FROM public."Фильмы"
  WHERE (("Фильмы"."Год" >= 2005) AND ("Фильмы"."Год" < 2010))
UNION
 SELECT avg("Фильмы"."Бюджет") AS avg
   FROM public."Фильмы"
  WHERE (("Фильмы"."Год" >= 2010) AND ("Фильмы"."Год" < 2020));


ALTER TABLE public.task7in4list OWNER TO postgres;

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
-- Name: task8in4list; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.task8in4list AS
 SELECT sum("Фильмы"."Бюджет") AS sum
   FROM public."Фильмы"
  WHERE ("Фильмы"."Счетчик" IN ( SELECT "Связи_Фильмы_Режиссёры"."Фильмы"
           FROM public."Связи_Фильмы_Режиссёры"
          WHERE ("Связи_Фильмы_Режиссёры"."Режиссёры" IN ( SELECT "Режиссёры"."Счетчик"
                   FROM public."Режиссёры"
                  WHERE ((("Режиссёры"."Фамилия")::text ~* 'в$'::text) OR (("Режиссёры"."Фамилия")::text ~* 'Н$'::text))))));


ALTER TABLE public.task8in4list OWNER TO postgres;

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
-- Name: АктерыБольше10Фильмов; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."АктерыБольше10Фильмов" AS
 SELECT "Номер_Фильма"."Фильмы"
   FROM ( SELECT count(*) AS count,
            "Связи_Фильмы_Актеры"."Фильмы"
           FROM public."Связи_Фильмы_Актеры"
          GROUP BY "Связи_Фильмы_Актеры"."Фильмы"
         HAVING (count(*) > 10)) "Номер_Фильма";


ALTER TABLE public."АктерыБольше10Фильмов" OWNER TO postgres;

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
-- Name: АктерыВФильмахОт2007До2010Режиссёро; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."АктерыВФильмахОт2007До2010Режиссёро" AS
 SELECT "Связи_Фильмы_Актеры"."Актеры"
   FROM public."Связи_Фильмы_Актеры"
  WHERE ("Связи_Фильмы_Актеры"."Фильмы" IN ( SELECT "Фильмы"."Счетчик"
           FROM public."Фильмы"
          WHERE (("Фильмы"."Счетчик" IN ( SELECT "Связи_Фильмы_Режиссёры"."Фильмы"
                   FROM public."Связи_Фильмы_Режиссёры"
                  WHERE ("Связи_Фильмы_Режиссёры"."Режиссёры" IN ( SELECT "Режиссёры"."Счетчик"
                           FROM public."Режиссёры"
                          WHERE (("Режиссёры"."СтранаРождения")::text = 'Англия'::text))))) AND ("Фильмы"."Год" >= 2007) AND ("Фильмы"."Год" <= 2010))));


ALTER TABLE public."АктерыВФильмахОт2007До2010Режиссёро" OWNER TO postgres;

--
-- Name: АктерыИзУжасов; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."АктерыИзУжасов" AS
 SELECT "Актеры"."Имя",
    "Актеры"."Фамилия"
   FROM public."Актеры",
    public."Фильмы",
    public."Связи_Фильмы_Актеры"
  WHERE (("Актеры"."Счетчик" = "Связи_Фильмы_Актеры"."Актеры") AND ("Фильмы"."Счетчик" = "Связи_Фильмы_Актеры"."Фильмы") AND (("Фильмы"."Жанры")::text = 'Ужасы'::text));


ALTER TABLE public."АктерыИзУжасов" OWNER TO postgres;

--
-- Name: ВсеФильмыБюджетКоторыхМеньшеМин; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."ВсеФильмыБюджетКоторыхМеньшеМин" AS
 SELECT "Фильмы"."Наименование"
   FROM public."Фильмы"
  WHERE (("Фильмы"."Бюджет" > ( SELECT min("Фильмы_1"."Бюджет") AS "МинимальныйБюджетНовыхФильмов"
           FROM public."Фильмы" "Фильмы_1"
          WHERE ("Фильмы_1"."Год" > 2010))) AND ("Фильмы"."Год" < 2010));


ALTER TABLE public."ВсеФильмыБюджетКоторыхМеньшеМин" OWNER TO postgres;

--
-- Name: Жанры; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Жанры" (
    "Жанр" character varying(50) NOT NULL
);


ALTER TABLE public."Жанры" OWNER TO postgres;

--
-- Name: ЖанрыСБолее5Фильмами; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."ЖанрыСБолее5Фильмами" AS
 SELECT count(*) AS count,
    "Фильмы"."Жанры"
   FROM public."Фильмы"
  GROUP BY "Фильмы"."Жанры"
 HAVING (count(*) > 5);


ALTER TABLE public."ЖанрыСБолее5Фильмами" OWNER TO postgres;

--
-- Name: ЖанрыФильмовРежиссёровИзАнглииИ; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."ЖанрыФильмовРежиссёровИзАнглииИ" AS
 SELECT "Фильмы"."Жанры"
   FROM public."Фильмы"
  WHERE ("Фильмы"."Счетчик" IN ( SELECT "Связи_Фильмы_Режиссёры"."Фильмы"
           FROM public."Режиссёры",
            public."Связи_Фильмы_Режиссёры"
          WHERE (("Режиссёры"."Счетчик" = "Связи_Фильмы_Режиссёры"."Режиссёры") AND ((("Режиссёры"."СтранаРождения")::text = 'Америка'::text) OR (("Режиссёры"."СтранаРождения")::text = 'Франция'::text)))));


ALTER TABLE public."ЖанрыФильмовРежиссёровИзАнглииИ" OWNER TO postgres;

--
-- Name: ЛучшийФильм2000join; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."ЛучшийФильм2000join" AS
 SELECT "Фильмы"."Наименование",
    "Режиссёры"."Фамилия",
    "Режиссёры"."Имя"
   FROM ((public."Фильмы"
     JOIN public."Режиссёры" ON (("Режиссёры"."ЛучшийФильм" = "Фильмы"."Счетчик")))
     JOIN public."Связи_Фильмы_Режиссёры" ON (("Связи_Фильмы_Режиссёры"."Режиссёры" = "Режиссёры"."Счетчик")))
  WHERE ("Фильмы"."Год" = 2000);


ALTER TABLE public."ЛучшийФильм2000join" OWNER TO postgres;

--
-- Name: ЛучшийФильмВ2000; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."ЛучшийФильмВ2000" AS
 SELECT "Фильмы"."Наименование",
    "Режиссёры"."Фамилия",
    "Режиссёры"."Имя"
   FROM public."Режиссёры",
    public."Связи_Фильмы_Режиссёры",
    public."Фильмы"
  WHERE (("Режиссёры"."ЛучшийФильм" = "Фильмы"."Счетчик") AND ("Связи_Фильмы_Режиссёры"."Режиссёры" = "Режиссёры"."Счетчик") AND ("Фильмы"."Год" = 2000));


ALTER TABLE public."ЛучшийФильмВ2000" OWNER TO postgres;

--
-- Name: МаксимальныйБюджетЗаГоды; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."МаксимальныйБюджетЗаГоды" AS
 SELECT "Фильмы"."Год",
    max("Фильмы"."Бюджет") AS "МаксимальныйБюджет"
   FROM public."Фильмы"
  GROUP BY "Фильмы"."Год";


ALTER TABLE public."МаксимальныйБюджетЗаГоды" OWNER TO postgres;

--
-- Name: РежиссёрыБольше5Фильмов; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."РежиссёрыБольше5Фильмов" AS
 SELECT "Режиссёры"."Имя",
    "Режиссёры"."Фамилия"
   FROM public."Режиссёры"
  WHERE ("Режиссёры"."Счетчик" IN ( SELECT "Номер_Режиссёра"."Режиссёры"
           FROM ( SELECT count(*) AS count,
                    "Связи_Фильмы_Режиссёры"."Режиссёры"
                   FROM public."Связи_Фильмы_Режиссёры"
                  GROUP BY "Связи_Фильмы_Режиссёры"."Режиссёры"
                 HAVING (count(*) > 5)) "Номер_Режиссёра"));


ALTER TABLE public."РежиссёрыБольше5Фильмов" OWNER TO postgres;

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
-- Name: Топ10Фильмов; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."Топ10Фильмов" AS
 SELECT "Фильмы".*::public."Фильмы" AS "Фильмы",
    "Фильмы"."Оценка"
   FROM public."Фильмы"
  WHERE ("Фильмы"."Страна" = 'USA'::public.country)
  ORDER BY "Фильмы"."Оценка" DESC
 LIMIT 10;


ALTER TABLE public."Топ10Фильмов" OWNER TO postgres;

--
-- Name: ФильмыТоп10ПоПродолжительности; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public."ФильмыТоп10ПоПродолжительности" AS
 SELECT "Фильмы"."Наименование",
    "Фильмы"."Счетчик"
   FROM public."Фильмы"
  ORDER BY "Фильмы"."Продолжительность" DESC
 OFFSET 10
 LIMIT 10;


ALTER TABLE public."ФильмыТоп10ПоПродолжительности" OWNER TO postgres;

--
-- Data for Name: Актеры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Актеры" VALUES ('Иванов', 'Александр', '1999-01-03', 'Россия', 10, 1);
INSERT INTO public."Актеры" VALUES ('Александров', 'Никита', '1982-05-03', 'Литва', 6, 3);
INSERT INTO public."Актеры" VALUES ('Пуглов', 'Иван', '1983-07-22', 'Россия', 9, 4);
INSERT INTO public."Актеры" VALUES ('Лейков', 'Илья', '1996-06-12', 'Россия', 11, 5);
INSERT INTO public."Актеры" VALUES ('Коньнова', 'Алия', '1999-04-01', 'Латвия', 7, 6);
INSERT INTO public."Актеры" VALUES ('Коньнов', 'Андрей', '1993-05-04', 'Латвия', 14, 7);
INSERT INTO public."Актеры" VALUES ('Иванов', 'Александр', '1999-03-11', 'Америка', 12, 8);
INSERT INTO public."Актеры" VALUES ('Иванов', 'Олег', '1999-03-11', 'Америка', 12, 9);
INSERT INTO public."Актеры" VALUES ('Иванов', 'Денис', '1999-03-11', 'Америка', 12, 10);
INSERT INTO public."Актеры" VALUES ('Иванов', 'Илья', '1999-03-11', 'Америка', 12, 11);
INSERT INTO public."Актеры" VALUES ('Иванов', 'Егор', '1999-03-11', 'Америка', 12, 12);
INSERT INTO public."Актеры" VALUES ('Иванов', 'Вадим', '1999-03-11', 'Америка', 12, 13);


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

INSERT INTO public."Режиссёры" VALUES ('Коньнова', 'Анна', '1998-04-02', 'Латвия', 2, 8);
INSERT INTO public."Режиссёры" VALUES ('Иванов', 'Сергей', '1996-01-10', 'Россия', 3, 9);
INSERT INTO public."Режиссёры" VALUES ('Иновиан', 'Олег', '1992-01-16', 'Латвия', 4, 11);
INSERT INTO public."Режиссёры" VALUES ('Каплин', 'Александра', '1992-10-16', 'Америка', 5, 12);
INSERT INTO public."Режиссёры" VALUES ('Куплинов', 'Сергей', '1986-09-27', 'Россия', 6, 13);
INSERT INTO public."Режиссёры" VALUES ('Пиронов', 'Иван', '1991-05-02', 'Америка', 1, 13);
INSERT INTO public."Режиссёры" VALUES ('Семенов', 'Семен', '1903-11-11', 'Англия', 7, 11);


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
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 7);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 9);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 10);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 11);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 12);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 13);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 14);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 15);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 16);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 18);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (1, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (3, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (4, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (5, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (6, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (7, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (8, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (9, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (10, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (11, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (12, 8);
INSERT INTO public."Связи_Фильмы_Актеры" VALUES (13, 8);


--
-- Data for Name: Связи_Фильмы_Режиссёры; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (13, 2);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (12, 3);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (13, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (8, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (8, 6);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (8, 2);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (10, 2);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (11, 3);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (13, 1);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (7, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (8, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (9, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (10, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (11, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (12, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (13, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (14, 4);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (14, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (13, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (12, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (11, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (10, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (9, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (8, 5);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (11, 7);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (12, 7);
INSERT INTO public."Связи_Фильмы_Режиссёры" VALUES (13, 7);


--
-- Data for Name: Фильмы; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Фильмы" VALUES ('Описание фильма', 'Романтика', 1922, 8000, '1922(1922)', 15, 15, 'USA', 6.8, 113);
INSERT INTO public."Фильмы" VALUES ('Описание фильма', 'Романтика', 2010, 7200, '2010(2010)', 16, 16, 'USA', 9.5, 63);
INSERT INTO public."Фильмы" VALUES ('Описание фильма', 'Ужасы', 2018, 7200, '2018(2018)', 18, 18, 'USA', 9.5, 63);
INSERT INTO public."Фильмы" VALUES ('Фильм про любовь', 'Романтика', 2000, 7300, 'LOVE(2000)', 13, 13, 'USA', 9.2, 145);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2003, 8130, 'РОМАнтика(2003)', 19, 19, 'UK', 6.5, 64);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2002, 8130, 'РОМАнтика.Начало(2002)', 20, 20, 'UK', 9.4, 64);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2010, 8630, 'РОМАнтика.Конец(2010)', 21, 21, 'UK', NULL, NULL);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2010, 8630, '555(2010)', 22, 22, 'USA', 6.6, 100);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2010, 8630, '666(2010)', 23, 23, 'USA', 8.0, 106);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2010, 8630, '777(2010)', 24, 24, 'USA', 9.2, 82);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2012, 4430, '888(2012)', 25, 25, 'USA', 10, 91);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2012, 4430, '999(2012)', 26, 26, 'USA', 10, 141);
INSERT INTO public."Фильмы" VALUES ('Описание', 'Романтика', 2014, 4430, '000(2014)', 27, 27, 'USA', 9.1, 122);
INSERT INTO public."Фильмы" VALUES ('Фильм просто', 'Ужасы', 2016, 6000, 'Фильмик 2016', 28, 28, 'USA', 3.4, 121);
INSERT INTO public."Фильмы" VALUES ('Фильм про открытие', 'Приключение', 2006, 1900, 'Открытие(2006)', 7, 7, 'UK', 7.8, 120);
INSERT INTO public."Фильмы" VALUES ('Фильм про закрытие', 'Ужасы', 2010, 8900, 'Закрытие(2010)', 8, 8, 'UK', 9.2, 72);
INSERT INTO public."Фильмы" VALUES ('Фильм про прилет', 'Романтика', 1999, 7000, 'Прилет(1999)', 9, 9, 'UK', 2.2, 102);
INSERT INTO public."Фильмы" VALUES ('Фильм про отлет', 'Драма', 2013, 7600, 'Отлет(2013)', 10, 10, 'UK', 5.6, 100);
INSERT INTO public."Фильмы" VALUES ('Фильм про начало', 'Приключение', 2010, 6000, 'Начало(2010)', 11, 11, 'UK', 6.9, 120);
INSERT INTO public."Фильмы" VALUES ('Фильм про конец', 'Приключение', 2015, 9000, 'Конец(2015)', 12, 12, 'UK', 8.0, 141);
INSERT INTO public."Фильмы" VALUES ('Описание фильма', 'Ужасы', 2000, 8000, '2000(2000)', 14, 14, 'USA', 9.8, 103);


--
-- Name: movie_id_numer; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.movie_id_numer', 28, true);


--
-- Name: СчетчикАктеры; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СчетчикАктеры"', 13, true);


--
-- Name: СчетчикРежиссёры; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СчетчикРежиссёры"', 7, true);


--
-- Name: СчетчикФильмов; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."СчетчикФильмов"', 28, true);


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

