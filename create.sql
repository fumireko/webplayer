--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Name: tb_albums; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_albums (
    id_album bigint NOT NULL,
    album_image_url character varying(255),
    release_date timestamp(6) without time zone,
    album_title character varying(512),
    fk_artist bigint
);


--
-- Name: tb_albums_artists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_albums_artists (
    fk_album bigint NOT NULL,
    fk_artist bigint NOT NULL
);


--
-- Name: tb_albums_id_album_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_albums_id_album_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_albums_id_album_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_albums_id_album_seq OWNED BY public.tb_albums.id_album;


--
-- Name: tb_artists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_artists (
    id_artist bigint NOT NULL,
    artist_name character varying(512) NOT NULL,
    description text,
    country_code character(4)
);


--
-- Name: tb_artists_genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_artists_genre (
    fk_artist bigint NOT NULL,
    fk_genre bigint NOT NULL
);


--
-- Name: tb_artists_id_artist_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_artists_id_artist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_artists_id_artist_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_artists_id_artist_seq OWNED BY public.tb_artists.id_artist;


--
-- Name: tb_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_files (
    id_file bigint NOT NULL,
    name character varying(255),
    url character varying(255)
);


--
-- Name: tb_files_id_file_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_files_id_file_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_files_id_file_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_files_id_file_seq OWNED BY public.tb_files.id_file;


--
-- Name: tb_genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_genres (
    id_genre bigint NOT NULL,
    description character varying(255)
);


--
-- Name: tb_genres_id_genre_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_genres_id_genre_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_genres_id_genre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_genres_id_genre_seq OWNED BY public.tb_genres.id_genre;


--
-- Name: tb_playlists; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_playlists (
    id_playlist bigint NOT NULL,
    playlist_name character varying(100),
    fk_user bigint
);


--
-- Name: tb_playlists_id_playlist_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_playlists_id_playlist_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_playlists_id_playlist_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_playlists_id_playlist_seq OWNED BY public.tb_playlists.id_playlist;


--
-- Name: tb_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_roles (
    id integer NOT NULL,
    role_name character varying(20),
    CONSTRAINT tb_roles_role_name_check CHECK (((role_name)::text = ANY ((ARRAY['ROLE_USER'::character varying, 'ROLE_MODERATOR'::character varying, 'ROLE_ADMIN'::character varying])::text[])))
);


--
-- Name: tb_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_roles_id_seq OWNED BY public.tb_roles.id;


--
-- Name: tb_songs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_songs (
    id_song bigint NOT NULL,
    song_length integer,
    song_title character varying(512),
    fk_album bigint,
    fk_file bigint
);


--
-- Name: tb_songs_album; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_songs_album (
    fk_song bigint NOT NULL,
    fk_album bigint NOT NULL
);


--
-- Name: tb_songs_id_song_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_songs_id_song_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_songs_id_song_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_songs_id_song_seq OWNED BY public.tb_songs.id_song;


--
-- Name: tb_songs_playlist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_songs_playlist (
    fk_playlist bigint NOT NULL,
    fk_song bigint NOT NULL
);


--
-- Name: tb_user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_user_roles (
    fk_user bigint NOT NULL,
    fk_role integer NOT NULL
);


--
-- Name: tb_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tb_users (
    id_user bigint NOT NULL,
    email character varying(64),
    password character varying(128),
    username character varying(64)
);


--
-- Name: tb_users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tb_users_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tb_users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tb_users_id_user_seq OWNED BY public.tb_users.id_user;


--
-- Name: tb_albums id_album; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_albums ALTER COLUMN id_album SET DEFAULT nextval('public.tb_albums_id_album_seq'::regclass);


--
-- Name: tb_artists id_artist; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_artists ALTER COLUMN id_artist SET DEFAULT nextval('public.tb_artists_id_artist_seq'::regclass);


--
-- Name: tb_files id_file; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_files ALTER COLUMN id_file SET DEFAULT nextval('public.tb_files_id_file_seq'::regclass);


--
-- Name: tb_genres id_genre; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_genres ALTER COLUMN id_genre SET DEFAULT nextval('public.tb_genres_id_genre_seq'::regclass);


--
-- Name: tb_playlists id_playlist; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_playlists ALTER COLUMN id_playlist SET DEFAULT nextval('public.tb_playlists_id_playlist_seq'::regclass);


--
-- Name: tb_roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_roles ALTER COLUMN id SET DEFAULT nextval('public.tb_roles_id_seq'::regclass);


--
-- Name: tb_songs id_song; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs ALTER COLUMN id_song SET DEFAULT nextval('public.tb_songs_id_song_seq'::regclass);


--
-- Name: tb_users id_user; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_users ALTER COLUMN id_user SET DEFAULT nextval('public.tb_users_id_user_seq'::regclass);


--
-- Data for Name: tb_albums; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_albums VALUES (1, 'http://localhost:8080/files/youwillneverknowwhy.jpg', '2009-09-27 21:00:00', 'You Will Never Know Why', NULL);
INSERT INTO public.tb_albums VALUES (2, 'http://localhost:8080/files/il_mondo_omote.jpg', '2007-12-30 22:00:00', 'il Mondo dove e finito il Tempo', NULL);
INSERT INTO public.tb_albums VALUES (3, 'http://localhost:8080/files/stigma.jpg', '2005-10-01 21:00:00', 'Stigma', NULL);
INSERT INTO public.tb_albums VALUES (4, 'http://localhost:8080/files/stories.jpg', '2013-12-29 22:00:00', 'Stories That Last Through the Sleepless Nights ', NULL);


--
-- Data for Name: tb_albums_artists; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_albums_artists VALUES (1, 1);
INSERT INTO public.tb_albums_artists VALUES (2, 2);
INSERT INTO public.tb_albums_artists VALUES (3, 3);
INSERT INTO public.tb_albums_artists VALUES (4, 4);


--
-- Data for Name: tb_artists; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_artists VALUES (1, 'Sweet Trip', 'American dream pop band', '231 ');
INSERT INTO public.tb_artists VALUES (2, 'Demetori', 'Japanese metal band', '109 ');
INSERT INTO public.tb_artists VALUES (3, '妖精帝國', 'Japanese gothic metal group', '109 ');
INSERT INTO public.tb_artists VALUES (4, 'Foreground Eclipse', 'meramipop', '109 ');


--
-- Data for Name: tb_artists_genre; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_artists_genre VALUES (1, 1);
INSERT INTO public.tb_artists_genre VALUES (1, 2);
INSERT INTO public.tb_artists_genre VALUES (2, 4);
INSERT INTO public.tb_artists_genre VALUES (2, 3);
INSERT INTO public.tb_artists_genre VALUES (3, 5);
INSERT INTO public.tb_artists_genre VALUES (3, 6);
INSERT INTO public.tb_artists_genre VALUES (4, 7);
INSERT INTO public.tb_artists_genre VALUES (4, 8);


--
-- Data for Name: tb_files; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_files VALUES (1, 'Sweet trip - 01 - Conservation of Two.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2001%20-%20Conservation%20of%20Two.mp3');
INSERT INTO public.tb_files VALUES (2, 'Sweet trip - 02 - Air Supply.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2002%20-%20Air%20Supply.mp3');
INSERT INTO public.tb_files VALUES (3, 'Sweet trip - 03 - Forever.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2003%20-%20Forever.mp3');
INSERT INTO public.tb_files VALUES (4, 'Sweet trip - 04 - Acting.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2004%20-%20Acting.mp3');
INSERT INTO public.tb_files VALUES (5, 'Sweet trip - 05 - Milk.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2005%20-%20Milk.mp3');
INSERT INTO public.tb_files VALUES (6, 'Sweet trip - 06 - Darkness.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2006%20-%20Darkness.mp3');
INSERT INTO public.tb_files VALUES (7, 'Sweet trip - 07 - To the Moon.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2007%20-%20To%20the%20Moon.mp3');
INSERT INTO public.tb_files VALUES (8, 'Sweet trip - 08 - Song About a Sea.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2008%20-%20Song%20About%20a%20Sea.mp3');
INSERT INTO public.tb_files VALUES (9, 'Sweet trip - 09 - Song About a Sun.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2009%20-%20Song%20About%20a%20Sun.mp3');
INSERT INTO public.tb_files VALUES (10, 'Sweet trip - 10 - No Words to Be Found.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2010%20-%20No%20Words%20to%20Be%20Found.mp3');
INSERT INTO public.tb_files VALUES (11, 'Sweet trip - 11 - Pretending.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2011%20-%20Pretending.mp3');
INSERT INTO public.tb_files VALUES (12, 'Sweet trip - 12 - Misfortunes Are Cruel.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2012%20-%20Misfortunes%20Are%20Cruel.mp3');
INSERT INTO public.tb_files VALUES (13, 'Sweet trip - 13 - Your World Is Eternally Complete.mp3', 'http://localhost:8080/files/Sweet%20trip%20-%2013%20-%20Your%20World%20Is%20Eternally%20Complete.mp3');
INSERT INTO public.tb_files VALUES (14, '01. Eastern Dream　～ The Introduction.mp3', 'http://localhost:8080/files/01.%20Eastern%20Dream%E3%80%80%EF%BD%9E%20The%20Introduction.mp3');
INSERT INTO public.tb_files VALUES (15, '02. The Venerable Ancient Battlefield ~ Suwa Foughten Field.mp3', 'http://localhost:8080/files/02.%20%C2%90The%20Venerable%20Ancient%20Battlefield%20~%20Suwa%20Foughten%20Field.mp3');
INSERT INTO public.tb_files VALUES (16, '03. Cemetery of Onbashira ~ Grave of the Shadow.mp3', 'http://localhost:8080/files/03.%20Cemetery%20of%20Onbashira%20~%20Grave%20of%20the%20Shadow.mp3');
INSERT INTO public.tb_files VALUES (17, '04. Lunar Clock ~ Luna Dial.mp3', 'http://localhost:8080/files/04.%20Lunar%20Clock%20~%20Luna%20Dial.mp3');
INSERT INTO public.tb_files VALUES (18, '05. Shanghai Scarlet Teahouse ~ Chinese Tea.mp3', 'http://localhost:8080/files/05.%20Shanghai%20Scarlet%20Teahouse%20~%20Chinese%20Tea.mp3');
INSERT INTO public.tb_files VALUES (19, '06. Tomboyish Girl in Love ~ killer Tune.mp3', 'http://localhost:8080/files/06.%20Tomboyish%20Girl%20in%20Love%20~%20killer%20Tune.mp3');
INSERT INTO public.tb_files VALUES (20, '07. Faith is for the Transient People ~ Jehovah''s YaHVeH.mp3', 'http://localhost:8080/files/07.%20%C2%90Faith%20is%20for%20the%20Transient%20People%20~%20Jehovah''s%20YaHVeH.mp3');
INSERT INTO public.tb_files VALUES (21, '08. Eastern Ghostly Dream ~ Ancient Temple.mp3', 'http://localhost:8080/files/08.%20Eastern%20Ghostly%20Dream%20~%20Ancient%20Temple.mp3');
INSERT INTO public.tb_files VALUES (22, '09. Spiritual Domination ~ Who done it!.mp3', 'http://localhost:8080/files/09.%20Spiritual%20Domination%20~%20Who%20done%20it!.mp3');
INSERT INTO public.tb_files VALUES (23, '10. Necrofantasia ~ Remix.mp3', 'http://localhost:8080/files/10.%20Necrofantasia%20~%20Remix.mp3');
INSERT INTO public.tb_files VALUES (24, '01 - Fee.mp3', 'http://localhost:8080/files/01%20-%20Fee.mp3');
INSERT INTO public.tb_files VALUES (25, '02 - Stigma.mp3', 'http://localhost:8080/files/02%20-%20Stigma.mp3');
INSERT INTO public.tb_files VALUES (26, '03 - Torikago.mp3', 'http://localhost:8080/files/03%20-%20Torikago.mp3');
INSERT INTO public.tb_files VALUES (27, '04 - Haru e.mp3', 'http://localhost:8080/files/04%20-%20Haru%20e.mp3');
INSERT INTO public.tb_files VALUES (28, '05 - Gekka Kyousou.mp3', 'http://localhost:8080/files/05%20-%20Gekka%20Kyousou.mp3');
INSERT INTO public.tb_files VALUES (29, '06 - Deep Sea.mp3', 'http://localhost:8080/files/06%20-%20Deep%20Sea.mp3');
INSERT INTO public.tb_files VALUES (30, '07 - Chinmoku no Mayu.mp3', 'http://localhost:8080/files/07%20-%20Chinmoku%20no%20Mayu.mp3');
INSERT INTO public.tb_files VALUES (31, '08 - Pray in the Darkness.mp3', 'http://localhost:8080/files/08%20-%20Pray%20in%20the%20Darkness.mp3');
INSERT INTO public.tb_files VALUES (32, '09 - Garden.mp3', 'http://localhost:8080/files/09%20-%20Garden.mp3');
INSERT INTO public.tb_files VALUES (33, '01. Foreground Eclipse - R.U..flac', 'http://localhost:8080/files/01.%20Foreground%20Eclipse%20-%20R.U..flac');
INSERT INTO public.tb_files VALUES (34, '02. Foreground Eclipse - Dear, Are You Getting Sober.flac', 'http://localhost:8080/files/02.%20Foreground%20Eclipse%20-%20Dear,%20Are%20You%20Getting%20Sober.flac');
INSERT INTO public.tb_files VALUES (35, '03. Foreground Eclipse - Last Liar Standing.flac', 'http://localhost:8080/files/03.%20Foreground%20Eclipse%20-%20Last%20Liar%20Standing.flac');
INSERT INTO public.tb_files VALUES (36, '04. Foreground Eclipse - Wandering, Never Wondering (There Exists A Shade).flac', 'http://localhost:8080/files/04.%20Foreground%20Eclipse%20-%20Wandering,%20Never%20Wondering%20(There%20Exists%20A%20Shade).flac');
INSERT INTO public.tb_files VALUES (37, '05. Foreground Eclipse - Truths, Ironies, The Secret Lyrics.flac', 'http://localhost:8080/files/05.%20Foreground%20Eclipse%20-%20Truths,%20Ironies,%20The%20Secret%20Lyrics.flac');
INSERT INTO public.tb_files VALUES (38, '06. Foreground Eclipse - (I Don''t Need Any Titles To This Song!).flac', 'http://localhost:8080/files/06.%20Foreground%20Eclipse%20-%20(I%20Don''t%20Need%20Any%20Titles%20To%20This%20Song!).flac');
INSERT INTO public.tb_files VALUES (39, '07. Foreground Eclipse - From Under Cover (Caught Up In A Love Song).flac', 'http://localhost:8080/files/07.%20Foreground%20Eclipse%20-%20From%20Under%20Cover%20(Caught%20Up%20In%20A%20Love%20Song).flac');
INSERT INTO public.tb_files VALUES (40, '08. Foreground Eclipse - Storytellers.flac', 'http://localhost:8080/files/08.%20Foreground%20Eclipse%20-%20Storytellers.flac');
INSERT INTO public.tb_files VALUES (41, '09. Foreground Eclipse - Koi no Twinkle Dance.flac', 'http://localhost:8080/files/09.%20Foreground%20Eclipse%20-%20Koi%20no%20Twinkle%C2%81%20Dance.flac');


--
-- Data for Name: tb_genres; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_genres VALUES (1, 'Dream Pop');
INSERT INTO public.tb_genres VALUES (2, 'Shoegaze');
INSERT INTO public.tb_genres VALUES (3, 'Instrumental');
INSERT INTO public.tb_genres VALUES (4, 'Heavy Metal');
INSERT INTO public.tb_genres VALUES (5, 'J-Pop');
INSERT INTO public.tb_genres VALUES (6, 'Symphonic Metal');
INSERT INTO public.tb_genres VALUES (7, 'Post-Hardcore');
INSERT INTO public.tb_genres VALUES (8, 'Melodic Metalcore');


--
-- Data for Name: tb_playlists; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: tb_roles; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: tb_songs; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_songs VALUES (1, 0, 'Conservation of Two', 1, 1);
INSERT INTO public.tb_songs VALUES (2, 0, 'Air Supply', 1, 2);
INSERT INTO public.tb_songs VALUES (3, 0, 'Forever', 1, 3);
INSERT INTO public.tb_songs VALUES (4, 0, 'Acting', 1, 4);
INSERT INTO public.tb_songs VALUES (5, 0, 'Milk', 1, 5);
INSERT INTO public.tb_songs VALUES (6, 0, 'Darkness', 1, 6);
INSERT INTO public.tb_songs VALUES (7, 0, 'To the Moon', 1, 7);
INSERT INTO public.tb_songs VALUES (8, 0, 'Song about a Sea', 1, 8);
INSERT INTO public.tb_songs VALUES (9, 0, 'Song about a Sun', 1, 9);
INSERT INTO public.tb_songs VALUES (10, 0, 'No Words to Be Found', 1, 10);
INSERT INTO public.tb_songs VALUES (11, 0, 'Pretending', 1, 11);
INSERT INTO public.tb_songs VALUES (12, 0, 'Misfortunes are Cruel', 1, 12);
INSERT INTO public.tb_songs VALUES (13, 0, 'Your World is Eternally Complete', 1, 13);
INSERT INTO public.tb_songs VALUES (14, 0, 'Eastern Dream ~ The Introduction', 2, 14);
INSERT INTO public.tb_songs VALUES (15, 0, '神さびた古戦場 ~ Suwa Foughten Field', 2, 15);
INSERT INTO public.tb_songs VALUES (16, 0, '御柱の墓場 ~ Grave of the Shadow', 2, 16);
INSERT INTO public.tb_songs VALUES (17, 0, '月時計 ~ ルナ・ダイアル', 2, 17);
INSERT INTO public.tb_songs VALUES (18, 0, '上海紅茶館 ~ Chinese Tea', 2, 18);
INSERT INTO public.tb_songs VALUES (19, 0, 'おてんば恋娘 ~ killer Tune', 2, 19);
INSERT INTO public.tb_songs VALUES (20, 0, '信仰は儚き人間の為に ~ Jehovah''s YaHVeH', 2, 20);
INSERT INTO public.tb_songs VALUES (21, 0, '東方妖々夢 ~ Ancient Temple', 2, 21);
INSERT INTO public.tb_songs VALUES (22, 0, '妖々跋扈 ~ Who done it！', 2, 22);
INSERT INTO public.tb_songs VALUES (23, 0, 'ネクロファンタジア ～ Remix', 2, 23);
INSERT INTO public.tb_songs VALUES (24, 0, 'Fee', 3, 24);
INSERT INTO public.tb_songs VALUES (25, 0, 'Stigma', 3, 25);
INSERT INTO public.tb_songs VALUES (26, 0, 'Torikago', 3, 26);
INSERT INTO public.tb_songs VALUES (27, 0, 'Haru e', 3, 27);
INSERT INTO public.tb_songs VALUES (28, 0, 'Gekka Kyousou', 3, 28);
INSERT INTO public.tb_songs VALUES (29, 0, 'Deep Sea', 3, 29);
INSERT INTO public.tb_songs VALUES (30, 0, 'Chinmoku no Mayu', 3, 30);
INSERT INTO public.tb_songs VALUES (31, 0, 'Pray in the Darkness', 3, 31);
INSERT INTO public.tb_songs VALUES (32, 0, 'Garden', 3, 32);
INSERT INTO public.tb_songs VALUES (33, 0, 'R.U.', 4, 33);
INSERT INTO public.tb_songs VALUES (34, 0, 'Dear, Are You Getting Sober', 4, 34);
INSERT INTO public.tb_songs VALUES (35, 0, 'Last Liar Standing', 4, 35);
INSERT INTO public.tb_songs VALUES (36, 0, 'Wandering, Never Wondering', 4, 36);
INSERT INTO public.tb_songs VALUES (37, 0, 'Truths, Ironies, The Secret Lyrics', 4, 37);
INSERT INTO public.tb_songs VALUES (38, 0, '(I Don''t Need Any Titles To This Song!)', 4, 38);
INSERT INTO public.tb_songs VALUES (39, 0, 'From Under Cover (Caught Up In a Love Song)', 4, 39);
INSERT INTO public.tb_songs VALUES (40, 0, 'Storytellers', 4, 40);
INSERT INTO public.tb_songs VALUES (41, 0, '恋のTwinkle☆Dance', 4, 41);


--
-- Data for Name: tb_songs_album; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: tb_songs_playlist; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: tb_user_roles; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Data for Name: tb_users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tb_users VALUES (1, 'test@mail.com', '$2a$10$dWcfKaUfufIpMqom1Vxije2fWi.1IluXFQAxbFBS9af2xP1yX.g22', 'test');


--
-- Name: tb_albums_id_album_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_albums_id_album_seq', 4, true);


--
-- Name: tb_artists_id_artist_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_artists_id_artist_seq', 4, true);


--
-- Name: tb_files_id_file_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_files_id_file_seq', 41, true);


--
-- Name: tb_genres_id_genre_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_genres_id_genre_seq', 8, true);


--
-- Name: tb_playlists_id_playlist_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_playlists_id_playlist_seq', 1, false);


--
-- Name: tb_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_roles_id_seq', 1, false);


--
-- Name: tb_songs_id_song_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_songs_id_song_seq', 41, true);


--
-- Name: tb_users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tb_users_id_user_seq', 1, false);


--
-- Name: tb_albums_artists tb_albums_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_albums_artists
    ADD CONSTRAINT tb_albums_artists_pkey PRIMARY KEY (fk_album, fk_artist);


--
-- Name: tb_albums tb_albums_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_albums
    ADD CONSTRAINT tb_albums_pkey PRIMARY KEY (id_album);


--
-- Name: tb_artists tb_artists_artist_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_artists
    ADD CONSTRAINT tb_artists_artist_name_key UNIQUE (artist_name);


--
-- Name: tb_artists_genre tb_artists_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_artists_genre
    ADD CONSTRAINT tb_artists_genre_pkey PRIMARY KEY (fk_artist, fk_genre);


--
-- Name: tb_artists tb_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_artists
    ADD CONSTRAINT tb_artists_pkey PRIMARY KEY (id_artist);


--
-- Name: tb_files tb_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_files
    ADD CONSTRAINT tb_files_pkey PRIMARY KEY (id_file);


--
-- Name: tb_genres tb_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_genres
    ADD CONSTRAINT tb_genres_pkey PRIMARY KEY (id_genre);


--
-- Name: tb_playlists tb_playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_playlists
    ADD CONSTRAINT tb_playlists_pkey PRIMARY KEY (id_playlist);


--
-- Name: tb_roles tb_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_roles
    ADD CONSTRAINT tb_roles_pkey PRIMARY KEY (id);


--
-- Name: tb_songs_album tb_songs_album_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs_album
    ADD CONSTRAINT tb_songs_album_pkey PRIMARY KEY (fk_song, fk_album);


--
-- Name: tb_songs tb_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs
    ADD CONSTRAINT tb_songs_pkey PRIMARY KEY (id_song);


--
-- Name: tb_user_roles tb_user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_user_roles
    ADD CONSTRAINT tb_user_roles_pkey PRIMARY KEY (fk_user, fk_role);


--
-- Name: tb_users tb_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_users
    ADD CONSTRAINT tb_users_pkey PRIMARY KEY (id_user);


--
-- Name: tb_users uk8n82lwp7lflhwda2v2v3wckc9; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_users
    ADD CONSTRAINT uk8n82lwp7lflhwda2v2v3wckc9 UNIQUE (username);


--
-- Name: tb_songs uk_rcbcpgcthsdgaeape49yaayxm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs
    ADD CONSTRAINT uk_rcbcpgcthsdgaeape49yaayxm UNIQUE (fk_file);


--
-- Name: tb_genres uk_shg7m7qswd5esq2830l2o9ee5; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_genres
    ADD CONSTRAINT uk_shg7m7qswd5esq2830l2o9ee5 UNIQUE (description);


--
-- Name: tb_users ukgrd22228p1miaivbn9yg178pm; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_users
    ADD CONSTRAINT ukgrd22228p1miaivbn9yg178pm UNIQUE (email);


--
-- Name: tb_songs_playlist fk2dc33iqas0tk8upv0raqr491a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs_playlist
    ADD CONSTRAINT fk2dc33iqas0tk8upv0raqr491a FOREIGN KEY (fk_playlist) REFERENCES public.tb_playlists(id_playlist);


--
-- Name: tb_songs_album fk6q2e0l6b537h266s0tqg3ten0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs_album
    ADD CONSTRAINT fk6q2e0l6b537h266s0tqg3ten0 FOREIGN KEY (fk_song) REFERENCES public.tb_albums(id_album);


--
-- Name: tb_songs fk7xor8wx7qbg9gldyn9pnsacve; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs
    ADD CONSTRAINT fk7xor8wx7qbg9gldyn9pnsacve FOREIGN KEY (fk_file) REFERENCES public.tb_files(id_file);


--
-- Name: tb_artists_genre fk8m670h4h0l7h55wyhpyynjr5g; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_artists_genre
    ADD CONSTRAINT fk8m670h4h0l7h55wyhpyynjr5g FOREIGN KEY (fk_artist) REFERENCES public.tb_artists(id_artist);


--
-- Name: tb_albums fk_artist; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_albums
    ADD CONSTRAINT fk_artist FOREIGN KEY (fk_artist) REFERENCES public.tb_artists(id_artist) ON DELETE CASCADE;


--
-- Name: tb_albums_artists fkaa0dxfa5vv3kjyjnw8fgvokn6; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_albums_artists
    ADD CONSTRAINT fkaa0dxfa5vv3kjyjnw8fgvokn6 FOREIGN KEY (fk_artist) REFERENCES public.tb_artists(id_artist);


--
-- Name: tb_playlists fkaalxro3ystifrpnt0nh9nbejb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_playlists
    ADD CONSTRAINT fkaalxro3ystifrpnt0nh9nbejb FOREIGN KEY (fk_user) REFERENCES public.tb_users(id_user);


--
-- Name: tb_songs_playlist fkd2k4ynp9ma72pvugm86jsepd3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs_playlist
    ADD CONSTRAINT fkd2k4ynp9ma72pvugm86jsepd3 FOREIGN KEY (fk_song) REFERENCES public.tb_songs(id_song);


--
-- Name: tb_albums_artists fkd5j7k0qdxuceopnwptjuqppbk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_albums_artists
    ADD CONSTRAINT fkd5j7k0qdxuceopnwptjuqppbk FOREIGN KEY (fk_album) REFERENCES public.tb_albums(id_album);


--
-- Name: tb_user_roles fkfd6bp42jpc5njg4fxsi8fy60a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_user_roles
    ADD CONSTRAINT fkfd6bp42jpc5njg4fxsi8fy60a FOREIGN KEY (fk_user) REFERENCES public.tb_users(id_user);


--
-- Name: tb_songs_album fkfnx3wh82q946dcfelmcha5fnb; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs_album
    ADD CONSTRAINT fkfnx3wh82q946dcfelmcha5fnb FOREIGN KEY (fk_album) REFERENCES public.tb_songs(id_song);


--
-- Name: tb_artists_genre fkl06axyjkrp8ixnx5dh5vfoirm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_artists_genre
    ADD CONSTRAINT fkl06axyjkrp8ixnx5dh5vfoirm FOREIGN KEY (fk_genre) REFERENCES public.tb_genres(id_genre);


--
-- Name: tb_user_roles fkl7uolpx6iraguc0qhqv9ph1e3; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_user_roles
    ADD CONSTRAINT fkl7uolpx6iraguc0qhqv9ph1e3 FOREIGN KEY (fk_role) REFERENCES public.tb_roles(id);


--
-- Name: tb_songs fkrtguuf7p8lxwge0xi7e8vpgqu; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tb_songs
    ADD CONSTRAINT fkrtguuf7p8lxwge0xi7e8vpgqu FOREIGN KEY (fk_album) REFERENCES public.tb_albums(id_album);


--
-- PostgreSQL database dump complete
--


DROP TABLE IF EXISTS tb_songs_playlist;
DROP TABLE IF EXISTS tb_songs_album;
DROP TABLE IF EXISTS tb_playlist_songs;
DROP TABLE IF EXISTS tb_playlists;
DROP TABLE IF EXISTS tb_songs;
DROP TABLE IF EXISTS tb_user_roles;
DROP TABLE IF EXISTS tb_users;
DROP TABLE IF EXISTS tb_roles;
DROP TABLE IF EXISTS tb_artists_genre;
DROP TABLE IF EXISTS tb_genres;
DROP TABLE IF EXISTS tb_albums_artists;
DROP TABLE IF EXISTS tb_albums;
DROP TABLE IF EXISTS tb_artists;

CREATE TABLE tb_artists (
    id_artist SERIAL PRIMARY KEY,
    artist_name character varying(512) NOT NULL UNIQUE,
    description text,
    country_code character(4)
);

CREATE TABLE tb_albums (
    id_album SERIAL PRIMARY KEY,
    album_title character varying(512) NOT NULL,
    album_image_url character varying(512),
    release_date timestamp without time zone,
    fk_artist bigint REFERENCES tb_artists(id_artist) ON DELETE CASCADE
);

CREATE TABLE tb_albums_artists (
    fk_album bigint REFERENCES tb_albums(id_album) ON DELETE CASCADE,
    fk_artist bigint REFERENCES tb_artists(id_artist) ON DELETE CASCADE,
    PRIMARY KEY (fk_album, fk_artist)
);

CREATE TABLE tb_genres (
    id_genre SERIAL PRIMARY KEY,
    description character varying(128) UNIQUE
);

CREATE TABLE tb_artists_genre (
    fk_artist bigint REFERENCES tb_artists(id_artist) ON DELETE CASCADE,
    fk_genre bigint REFERENCES tb_genres(id_genre) ON DELETE CASCADE,
    PRIMARY KEY (fk_artist, fk_genre)
);

CREATE TABLE tb_roles (
    id_role SERIAL PRIMARY KEY,
    role_name character varying(255) NOT NULL UNIQUE
);

CREATE TABLE tb_users (
    id_user SERIAL PRIMARY KEY,
    username character varying(255) NOT NULL UNIQUE,
    email character varying(255) NOT NULL UNIQUE,
    password character varying(255) NOT NULL
);

CREATE TABLE tb_user_roles (
    fk_user bigint REFERENCES tb_users(id_user) ON DELETE CASCADE,
    fk_role integer REFERENCES tb_roles(id_role) ON DELETE CASCADE,
    PRIMARY KEY (fk_user, fk_role)
);

CREATE TABLE tb_songs (
    id_song SERIAL PRIMARY KEY,
    song_title character varying(512),
    song_length integer,
    fk_album bigint REFERENCES tb_albums(id_album) ON DELETE CASCADE
);

CREATE TABLE tb_playlists (
    id_playlist SERIAL PRIMARY KEY,
    playlist_name character varying(100),
    fk_user bigint REFERENCES tb_users(id_user) ON DELETE CASCADE
);

CREATE TABLE tb_playlist_songs (
    date_added timestamp(6) without time zone,
    play_count integer,
    playlist_id bigint REFERENCES tb_playlists(id_playlist) ON DELETE CASCADE,
    song_id bigint REFERENCES tb_songs(id_song) ON DELETE CASCADE,
    PRIMARY KEY (playlist_id, song_id)
);

CREATE TABLE tb_songs_album (
    fk_song bigint REFERENCES tb_songs(id_song) ON DELETE CASCADE,
    fk_album bigint REFERENCES tb_albums(id_album) ON DELETE CASCADE,
    PRIMARY KEY (fk_song, fk_album)
);

CREATE TABLE tb_songs_playlist (
    fk_song bigint REFERENCES tb_songs(id_song) ON DELETE CASCADE,
    fk_playlist bigint REFERENCES tb_playlists(id_playlist) ON DELETE CASCADE,
    date_added timestamp without time zone,
    play_count integer,
    PRIMARY KEY (fk_song, fk_playlist)
);

INSERT INTO public.tb_roles (id_role, role_name) VALUES (1, 'ROLE_USER');
INSERT INTO public.tb_roles (id_role, role_name) VALUES (2, 'ROLE_MODERATOR');
INSERT INTO public.tb_roles (id_role, role_name) VALUES (3, 'ROLE_ADMIN');

INSERT INTO public.tb_users (id_user, username, email, password) VALUES (1, 'test', 'test@mail.com', '$2a$10$dWcfKaUfufIpMqom1Vxije2fWi.1IluXFQAxbFBS9af2xP1yX.g22');

INSERT INTO public.tb_user_roles (fk_user, fk_role) VALUES (1, 1);
INSERT INTO public.tb_user_roles (fk_user, fk_role) VALUES (1, 2);
INSERT INTO public.tb_user_roles (fk_user, fk_role) VALUES (1, 3);

INSERT INTO tb_artists (artist_name, description, country_code) 
VALUES 
('Taylor Swift', 'American singer-songwriter', 1),
('Ed Sheeran', 'British singer-songwriter', 2),
('Beyoncé', 'American singer, songwriter, and actress', 1),
('Drake', 'Canadian rapper, singer, and songwriter', 3),
('BTS', 'South Korean boy band', 4);

INSERT INTO tb_genres (description) 
VALUES 
('Pop'),
('R&B'),
('Hip Hop'),
('Rap'),
('K-Pop');

INSERT INTO tb_albums (album_title, album_image_url, release_date, fk_artist) 
VALUES 
('Fearless', 'https://example.com/fearless.jpg', '2008-11-11', 1),
('Divide', 'https://example.com/divide.jpg', '2017-03-03', 2),
('Lemonade', 'https://example.com/lemonade.jpg', '2016-04-23', 3),
('Scorpion', 'https://example.com/scorpion.jpg', '2018-06-29', 4),
('Love Yourself: Her', 'https://example.com/loveyourself.jpg', '2017-09-18', 5);

INSERT INTO tb_songs (song_title, song_length, fk_album) 
VALUES 
('Love Story', 235, 1),
('Shape of You', 231, 2),
('Formation', 240, 3),
('God''s Plan', 195, 4),
('DNA', 223, 5),
('White Horse', 245, 1),
('You Belong with Me', 218, 1),
('Castle on the Hill', 261, 2),
('Galway Girl', 170, 2),
('Sorry', 234, 3),
('Hold Up', 212, 3),
('In My Feelings', 217, 4),
('Nice for What', 210, 4),
('MIC Drop', 228, 5);

INSERT INTO tb_songs_album (fk_song, fk_album)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 1),
(7, 1),
(8, 2),
(9, 2),
(10, 3),
(11, 3),
(12, 4),
(13, 4),
(14, 5);

INSERT INTO tb_playlists (playlist_name, fk_user) 
VALUES 
('Favorites', 1),
('Workout Mix', 1),
('Chill Vibes', 1),
('Party Anthems', 1),
('Road Trip', 1);

-- Insert statements for associations
INSERT INTO tb_albums_artists (fk_album, fk_artist) 
VALUES 
(1, 1),
(1, 3),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

INSERT INTO tb_artists_genre (fk_artist, fk_genre) 
VALUES 
(1, 1),
(2, 1),
(3, 2),
(3, 3),
(4, 3),
(5, 5);

INSERT INTO tb_playlist_songs (date_added, play_count, playlist_id, song_id) 
VALUES 
('2023-01-15 12:00:00', 10, 1, 1),
('2022-05-20 14:00:00', 8, 2, 2),
('2023-11-08 16:00:00', 15, 3, 3),
('2024-02-03 18:00:00', 5, 4, 4),
('2022-09-12 20:00:00', 12, 5, 5);

INSERT INTO tb_songs_playlist (fk_song, fk_playlist, date_added, play_count) 
VALUES 
(1, 1, '2023-01-15 12:00:00', 5),
(2, 1, '2023-01-15 12:00:00', 3),
(3, 2, '2022-05-20 14:00:00', 7),
(4, 2, '2022-05-20 14:00:00', 2),
(5, 3, '2023-11-08 16:00:00', 8);
