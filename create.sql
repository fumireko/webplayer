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
-- Name: tb_albums; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_albums (
    id_album bigint NOT NULL,
    album_image_url character varying(255),
    release_date timestamp(6) without time zone,
    album_title character varying(512),
    fk_artist bigint
);


ALTER TABLE public.tb_albums OWNER TO postgres;

--
-- Name: tb_albums_artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_albums_artists (
    fk_album bigint NOT NULL,
    fk_artist bigint NOT NULL
);


ALTER TABLE public.tb_albums_artists OWNER TO postgres;

--
-- Name: tb_albums_id_album_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_albums_id_album_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_albums_id_album_seq OWNER TO postgres;

--
-- Name: tb_albums_id_album_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_albums_id_album_seq OWNED BY public.tb_albums.id_album;


--
-- Name: tb_artists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_artists (
    id_artist bigint NOT NULL,
    artist_name character varying(512) NOT NULL,
    description text,
    country_code character(4)
);


ALTER TABLE public.tb_artists OWNER TO postgres;

--
-- Name: tb_artists_genre; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_artists_genre (
    fk_artist bigint NOT NULL,
    fk_genre bigint NOT NULL
);


ALTER TABLE public.tb_artists_genre OWNER TO postgres;

--
-- Name: tb_artists_id_artist_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_artists_id_artist_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_artists_id_artist_seq OWNER TO postgres;

--
-- Name: tb_artists_id_artist_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_artists_id_artist_seq OWNED BY public.tb_artists.id_artist;


--
-- Name: tb_genres; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_genres (
    id_genre bigint NOT NULL,
    description character varying(255)
);


ALTER TABLE public.tb_genres OWNER TO postgres;

--
-- Name: tb_genres_id_genre_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_genres_id_genre_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_genres_id_genre_seq OWNER TO postgres;

--
-- Name: tb_genres_id_genre_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_genres_id_genre_seq OWNED BY public.tb_genres.id_genre;


--
-- Name: tb_playlists; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_playlists (
    id_playlist bigint NOT NULL,
    playlist_name character varying(100),
    fk_user bigint
);


ALTER TABLE public.tb_playlists OWNER TO postgres;

--
-- Name: tb_playlists_id_playlist_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_playlists_id_playlist_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_playlists_id_playlist_seq OWNER TO postgres;

--
-- Name: tb_playlists_id_playlist_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_playlists_id_playlist_seq OWNED BY public.tb_playlists.id_playlist;


--
-- Name: tb_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_roles (
    id integer NOT NULL,
    role_name character varying(20),
    CONSTRAINT tb_roles_role_name_check CHECK (((role_name)::text = ANY ((ARRAY['ROLE_USER'::character varying, 'ROLE_MODERATOR'::character varying, 'ROLE_ADMIN'::character varying])::text[])))
);


ALTER TABLE public.tb_roles OWNER TO postgres;

--
-- Name: tb_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_roles_id_seq OWNER TO postgres;

--
-- Name: tb_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_roles_id_seq OWNED BY public.tb_roles.id;


--
-- Name: tb_songs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_songs (
    id_song bigint NOT NULL,
    song_length integer,
    song_title character varying(512),
    fk_album bigint
);


ALTER TABLE public.tb_songs OWNER TO postgres;

--
-- Name: tb_songs_album; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_songs_album (
    fk_song bigint NOT NULL,
    fk_album bigint NOT NULL
);


ALTER TABLE public.tb_songs_album OWNER TO postgres;

--
-- Name: tb_songs_id_song_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_songs_id_song_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_songs_id_song_seq OWNER TO postgres;

--
-- Name: tb_songs_id_song_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_songs_id_song_seq OWNED BY public.tb_songs.id_song;


--
-- Name: tb_songs_playlist; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_songs_playlist (
    fk_playlist bigint NOT NULL,
    fk_song bigint NOT NULL
);


ALTER TABLE public.tb_songs_playlist OWNER TO postgres;

--
-- Name: tb_user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_user_roles (
    fk_user bigint NOT NULL,
    fk_role integer NOT NULL
);


ALTER TABLE public.tb_user_roles OWNER TO postgres;

--
-- Name: tb_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_users (
    id_user bigint NOT NULL,
    email character varying(64),
    password character varying(128),
    username character varying(64)
);


ALTER TABLE public.tb_users OWNER TO postgres;

--
-- Name: tb_users_id_user_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_users_id_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_users_id_user_seq OWNER TO postgres;

--
-- Name: tb_users_id_user_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_users_id_user_seq OWNED BY public.tb_users.id_user;


--
-- Name: tb_albums id_album; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_albums ALTER COLUMN id_album SET DEFAULT nextval('public.tb_albums_id_album_seq'::regclass);


--
-- Name: tb_artists id_artist; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_artists ALTER COLUMN id_artist SET DEFAULT nextval('public.tb_artists_id_artist_seq'::regclass);


--
-- Name: tb_genres id_genre; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_genres ALTER COLUMN id_genre SET DEFAULT nextval('public.tb_genres_id_genre_seq'::regclass);


--
-- Name: tb_playlists id_playlist; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_playlists ALTER COLUMN id_playlist SET DEFAULT nextval('public.tb_playlists_id_playlist_seq'::regclass);


--
-- Name: tb_roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_roles ALTER COLUMN id SET DEFAULT nextval('public.tb_roles_id_seq'::regclass);


--
-- Name: tb_songs id_song; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs ALTER COLUMN id_song SET DEFAULT nextval('public.tb_songs_id_song_seq'::regclass);


--
-- Name: tb_users id_user; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_users ALTER COLUMN id_user SET DEFAULT nextval('public.tb_users_id_user_seq'::regclass);


--
-- Data for Name: tb_albums; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_albums VALUES (1, 'https://example.com/fearless.jpg', '2008-11-11 00:00:00', 'Fearless', 1);
INSERT INTO public.tb_albums VALUES (2, 'https://example.com/divide.jpg', '2017-03-03 00:00:00', 'Divide', 2);
INSERT INTO public.tb_albums VALUES (3, 'https://example.com/lemonade.jpg', '2016-04-23 00:00:00', 'Lemonade', 3);
INSERT INTO public.tb_albums VALUES (5, 'https://example.com/loveyourself.jpg', '2017-09-18 00:00:00', 'Love Yourself: Her', 5);
INSERT INTO public.tb_albums VALUES (4, 'https://example.com/scorpion.jpg', '2018-06-28 21:00:00', 'Scorpion', 4);


--
-- Data for Name: tb_albums_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_albums_artists VALUES (1, 1);
INSERT INTO public.tb_albums_artists VALUES (1, 3);
INSERT INTO public.tb_albums_artists VALUES (2, 2);
INSERT INTO public.tb_albums_artists VALUES (3, 3);
INSERT INTO public.tb_albums_artists VALUES (5, 5);
INSERT INTO public.tb_albums_artists VALUES (4, 4);


--
-- Data for Name: tb_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_artists VALUES (1, 'Taylor Swift', 'American singer-songwriter', '1   ');
INSERT INTO public.tb_artists VALUES (2, 'Ed Sheeran', 'British singer-songwriter', '2   ');
INSERT INTO public.tb_artists VALUES (3, 'Beyoncé', 'American singer, songwriter, and actress', '1   ');
INSERT INTO public.tb_artists VALUES (4, 'Drake', 'Canadian rapper, singer, and songwriter', '3   ');
INSERT INTO public.tb_artists VALUES (5, 'BTS', 'South Korean boy band', '4   ');


--
-- Data for Name: tb_artists_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_artists_genre VALUES (1, 1);
INSERT INTO public.tb_artists_genre VALUES (2, 1);
INSERT INTO public.tb_artists_genre VALUES (3, 2);
INSERT INTO public.tb_artists_genre VALUES (3, 3);
INSERT INTO public.tb_artists_genre VALUES (4, 3);
INSERT INTO public.tb_artists_genre VALUES (5, 5);


--
-- Data for Name: tb_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_genres VALUES (1, 'Pop');
INSERT INTO public.tb_genres VALUES (2, 'R&B');
INSERT INTO public.tb_genres VALUES (3, 'Hip Hop');
INSERT INTO public.tb_genres VALUES (4, 'Rap');
INSERT INTO public.tb_genres VALUES (5, 'K-Pop');


--
-- Data for Name: tb_playlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_playlists VALUES (6, 'Favorites', 1);
INSERT INTO public.tb_playlists VALUES (7, 'Workout Mix', 1);
INSERT INTO public.tb_playlists VALUES (8, 'Chill Vibes', 1);
INSERT INTO public.tb_playlists VALUES (9, 'Party Anthems', 1);
INSERT INTO public.tb_playlists VALUES (10, 'Road Trip', 1);


--
-- Data for Name: tb_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_roles VALUES (1, 'ROLE_USER');
INSERT INTO public.tb_roles VALUES (2, 'ROLE_MODERATOR');
INSERT INTO public.tb_roles VALUES (3, 'ROLE_ADMIN');


--
-- Data for Name: tb_songs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_songs VALUES (1, 235, 'Love Story', 1);
INSERT INTO public.tb_songs VALUES (2, 231, 'Shape of You', 2);
INSERT INTO public.tb_songs VALUES (3, 240, 'Formation', 3);
INSERT INTO public.tb_songs VALUES (4, 195, 'God''s Plan', 4);
INSERT INTO public.tb_songs VALUES (5, 223, 'DNA', 5);
INSERT INTO public.tb_songs VALUES (6, 245, 'White Horse', 1);
INSERT INTO public.tb_songs VALUES (7, 218, 'You Belong with Me', 1);
INSERT INTO public.tb_songs VALUES (8, 261, 'Castle on the Hill', 2);
INSERT INTO public.tb_songs VALUES (9, 170, 'Galway Girl', 2);
INSERT INTO public.tb_songs VALUES (10, 234, 'Sorry', 3);
INSERT INTO public.tb_songs VALUES (11, 212, 'Hold Up', 3);
INSERT INTO public.tb_songs VALUES (12, 217, 'In My Feelings', 4);
INSERT INTO public.tb_songs VALUES (13, 210, 'Nice for What', 4);
INSERT INTO public.tb_songs VALUES (14, 228, 'MIC Drop', 5);


--
-- Data for Name: tb_songs_album; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tb_songs_playlist; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: tb_user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_user_roles VALUES (1, 1);
INSERT INTO public.tb_user_roles VALUES (1, 2);
INSERT INTO public.tb_user_roles VALUES (1, 3);


--
-- Data for Name: tb_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tb_users VALUES (1, 'test@mail.com', '$2a$10$dWcfKaUfufIpMqom1Vxije2fWi.1IluXFQAxbFBS9af2xP1yX.g22', 'test');


--
-- Name: tb_albums_id_album_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_albums_id_album_seq', 5, true);


--
-- Name: tb_artists_id_artist_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_artists_id_artist_seq', 5, true);


--
-- Name: tb_genres_id_genre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_genres_id_genre_seq', 5, true);


--
-- Name: tb_playlists_id_playlist_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_playlists_id_playlist_seq', 10, true);


--
-- Name: tb_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_roles_id_seq', 1, false);


--
-- Name: tb_songs_id_song_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_songs_id_song_seq', 14, true);


--
-- Name: tb_users_id_user_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_users_id_user_seq', 1, false);


--
-- Name: tb_albums_artists tb_albums_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_albums_artists
    ADD CONSTRAINT tb_albums_artists_pkey PRIMARY KEY (fk_album, fk_artist);


--
-- Name: tb_albums tb_albums_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_albums
    ADD CONSTRAINT tb_albums_pkey PRIMARY KEY (id_album);


--
-- Name: tb_artists tb_artists_artist_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_artists
    ADD CONSTRAINT tb_artists_artist_name_key UNIQUE (artist_name);


--
-- Name: tb_artists_genre tb_artists_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_artists_genre
    ADD CONSTRAINT tb_artists_genre_pkey PRIMARY KEY (fk_artist, fk_genre);


--
-- Name: tb_artists tb_artists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_artists
    ADD CONSTRAINT tb_artists_pkey PRIMARY KEY (id_artist);


--
-- Name: tb_genres tb_genres_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_genres
    ADD CONSTRAINT tb_genres_pkey PRIMARY KEY (id_genre);


--
-- Name: tb_playlists tb_playlists_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_playlists
    ADD CONSTRAINT tb_playlists_pkey PRIMARY KEY (id_playlist);


--
-- Name: tb_roles tb_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_roles
    ADD CONSTRAINT tb_roles_pkey PRIMARY KEY (id);


--
-- Name: tb_songs_album tb_songs_album_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs_album
    ADD CONSTRAINT tb_songs_album_pkey PRIMARY KEY (fk_song, fk_album);


--
-- Name: tb_songs tb_songs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs
    ADD CONSTRAINT tb_songs_pkey PRIMARY KEY (id_song);


--
-- Name: tb_user_roles tb_user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_roles
    ADD CONSTRAINT tb_user_roles_pkey PRIMARY KEY (fk_user, fk_role);


--
-- Name: tb_users tb_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_users
    ADD CONSTRAINT tb_users_pkey PRIMARY KEY (id_user);


--
-- Name: tb_users uk8n82lwp7lflhwda2v2v3wckc9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_users
    ADD CONSTRAINT uk8n82lwp7lflhwda2v2v3wckc9 UNIQUE (username);


--
-- Name: tb_genres uk_shg7m7qswd5esq2830l2o9ee5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_genres
    ADD CONSTRAINT uk_shg7m7qswd5esq2830l2o9ee5 UNIQUE (description);


--
-- Name: tb_users ukgrd22228p1miaivbn9yg178pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_users
    ADD CONSTRAINT ukgrd22228p1miaivbn9yg178pm UNIQUE (email);


--
-- Name: tb_songs_playlist fk2dc33iqas0tk8upv0raqr491a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs_playlist
    ADD CONSTRAINT fk2dc33iqas0tk8upv0raqr491a FOREIGN KEY (fk_playlist) REFERENCES public.tb_playlists(id_playlist);


--
-- Name: tb_songs_album fk6q2e0l6b537h266s0tqg3ten0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs_album
    ADD CONSTRAINT fk6q2e0l6b537h266s0tqg3ten0 FOREIGN KEY (fk_song) REFERENCES public.tb_albums(id_album);


--
-- Name: tb_artists_genre fk8m670h4h0l7h55wyhpyynjr5g; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_artists_genre
    ADD CONSTRAINT fk8m670h4h0l7h55wyhpyynjr5g FOREIGN KEY (fk_artist) REFERENCES public.tb_artists(id_artist);


--
-- Name: tb_albums fk_artist; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_albums
    ADD CONSTRAINT fk_artist FOREIGN KEY (fk_artist) REFERENCES public.tb_artists(id_artist) ON DELETE CASCADE;


--
-- Name: tb_albums_artists fkaa0dxfa5vv3kjyjnw8fgvokn6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_albums_artists
    ADD CONSTRAINT fkaa0dxfa5vv3kjyjnw8fgvokn6 FOREIGN KEY (fk_artist) REFERENCES public.tb_artists(id_artist);


--
-- Name: tb_playlists fkaalxro3ystifrpnt0nh9nbejb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_playlists
    ADD CONSTRAINT fkaalxro3ystifrpnt0nh9nbejb FOREIGN KEY (fk_user) REFERENCES public.tb_users(id_user);


--
-- Name: tb_songs_playlist fkd2k4ynp9ma72pvugm86jsepd3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs_playlist
    ADD CONSTRAINT fkd2k4ynp9ma72pvugm86jsepd3 FOREIGN KEY (fk_song) REFERENCES public.tb_songs(id_song);


--
-- Name: tb_albums_artists fkd5j7k0qdxuceopnwptjuqppbk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_albums_artists
    ADD CONSTRAINT fkd5j7k0qdxuceopnwptjuqppbk FOREIGN KEY (fk_album) REFERENCES public.tb_albums(id_album);


--
-- Name: tb_user_roles fkfd6bp42jpc5njg4fxsi8fy60a; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_roles
    ADD CONSTRAINT fkfd6bp42jpc5njg4fxsi8fy60a FOREIGN KEY (fk_user) REFERENCES public.tb_users(id_user);


--
-- Name: tb_songs_album fkfnx3wh82q946dcfelmcha5fnb; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs_album
    ADD CONSTRAINT fkfnx3wh82q946dcfelmcha5fnb FOREIGN KEY (fk_album) REFERENCES public.tb_songs(id_song);


--
-- Name: tb_artists_genre fkl06axyjkrp8ixnx5dh5vfoirm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_artists_genre
    ADD CONSTRAINT fkl06axyjkrp8ixnx5dh5vfoirm FOREIGN KEY (fk_genre) REFERENCES public.tb_genres(id_genre);


--
-- Name: tb_user_roles fkl7uolpx6iraguc0qhqv9ph1e3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_user_roles
    ADD CONSTRAINT fkl7uolpx6iraguc0qhqv9ph1e3 FOREIGN KEY (fk_role) REFERENCES public.tb_roles(id);


--
-- Name: tb_songs fkrtguuf7p8lxwge0xi7e8vpgqu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
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
