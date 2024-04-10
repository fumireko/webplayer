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
-- Name: tb_files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tb_files (
    id_file bigint NOT NULL,
    name character varying(255),
    url character varying(255)
);


ALTER TABLE public.tb_files OWNER TO postgres;

--
-- Name: tb_files_id_file_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tb_files_id_file_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tb_files_id_file_seq OWNER TO postgres;

--
-- Name: tb_files_id_file_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tb_files_id_file_seq OWNED BY public.tb_files.id_file;


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
    fk_album bigint,
    fk_file bigint
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
-- Name: tb_files id_file; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_files ALTER COLUMN id_file SET DEFAULT nextval('public.tb_files_id_file_seq'::regclass);


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

COPY public.tb_albums (id_album, album_image_url, release_date, album_title, fk_artist) FROM stdin;
1	http://localhost:8080/files/youwillneverknowwhy.jpg	2009-09-27 21:00:00	You Will Never Know Why	\N
2	http://localhost:8080/files/il_mondo_omote.jpg	2007-12-30 22:00:00	il Mondo dove e finito il Tempo	\N
3	http://localhost:8080/files/stigma.jpg	2005-10-01 21:00:00	Stigma	\N
4	http://localhost:8080/files/stories.jpg	2013-12-29 22:00:00	Stories That Last Through the Sleepless Nights 	\N
5	http://localhost:8080/files/sinen.jpg	2006-12-30 22:00:00	如臨深遠～雨縒煙柳	\N
6	http://localhost:8080/files/nadaupasanapundarika.JPG	2009-12-29 22:00:00	曼衍珠汝華 ～ Nada Upasana Pundarika	\N
7	http://localhost:8080/files/eachandevery.jpg	2011-12-29 22:00:00	Each And Every Word Leaves Me Here Alone	\N
8	http://localhost:8080/files/Portal_Of_I.png	2012-05-06 21:00:00	Portal of I	\N
9	http://localhost:8080/files/transwing_theinnergaze.jpg	2010-12-29 22:00:00	TRanswing -The Inner Gaze-	\N
10	http://localhost:8080/files/somersault.jpg	2011-08-11 21:00:00	Somersault	\N
\.


--
-- Data for Name: tb_albums_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_albums_artists (fk_album, fk_artist) FROM stdin;
1	1
2	2
3	3
4	4
5	2
6	2
7	4
8	5
9	6
10	6
\.


--
-- Data for Name: tb_artists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_artists (id_artist, artist_name, description, country_code) FROM stdin;
1	Sweet Trip	American dream pop band	231 
2	Demetori	Japanese metal band	109 
3	妖精帝國	Japanese gothic metal group	109 
4	Foreground Eclipse	meramipop	109 
5	Ne Obliviscaris	Australian metal band	13  
6	TRäkker	Formed by Taishi and 青葉りんご (Aoba Ringo)	109 
\.


--
-- Data for Name: tb_artists_genre; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_artists_genre (fk_artist, fk_genre) FROM stdin;
1	1
1	2
2	4
2	3
3	5
3	6
4	7
4	8
5	6
5	4
6	3
6	10
6	9
\.


--
-- Data for Name: tb_files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_files (id_file, name, url) FROM stdin;
1	Sweet trip - 01 - Conservation of Two.mp3	http://localhost:8080/files/Sweet%20trip%20-%2001%20-%20Conservation%20of%20Two.mp3
2	Sweet trip - 02 - Air Supply.mp3	http://localhost:8080/files/Sweet%20trip%20-%2002%20-%20Air%20Supply.mp3
3	Sweet trip - 03 - Forever.mp3	http://localhost:8080/files/Sweet%20trip%20-%2003%20-%20Forever.mp3
4	Sweet trip - 04 - Acting.mp3	http://localhost:8080/files/Sweet%20trip%20-%2004%20-%20Acting.mp3
5	Sweet trip - 05 - Milk.mp3	http://localhost:8080/files/Sweet%20trip%20-%2005%20-%20Milk.mp3
6	Sweet trip - 06 - Darkness.mp3	http://localhost:8080/files/Sweet%20trip%20-%2006%20-%20Darkness.mp3
7	Sweet trip - 07 - To the Moon.mp3	http://localhost:8080/files/Sweet%20trip%20-%2007%20-%20To%20the%20Moon.mp3
8	Sweet trip - 08 - Song About a Sea.mp3	http://localhost:8080/files/Sweet%20trip%20-%2008%20-%20Song%20About%20a%20Sea.mp3
9	Sweet trip - 09 - Song About a Sun.mp3	http://localhost:8080/files/Sweet%20trip%20-%2009%20-%20Song%20About%20a%20Sun.mp3
10	Sweet trip - 10 - No Words to Be Found.mp3	http://localhost:8080/files/Sweet%20trip%20-%2010%20-%20No%20Words%20to%20Be%20Found.mp3
11	Sweet trip - 11 - Pretending.mp3	http://localhost:8080/files/Sweet%20trip%20-%2011%20-%20Pretending.mp3
12	Sweet trip - 12 - Misfortunes Are Cruel.mp3	http://localhost:8080/files/Sweet%20trip%20-%2012%20-%20Misfortunes%20Are%20Cruel.mp3
13	Sweet trip - 13 - Your World Is Eternally Complete.mp3	http://localhost:8080/files/Sweet%20trip%20-%2013%20-%20Your%20World%20Is%20Eternally%20Complete.mp3
14	01. Eastern Dream　～ The Introduction.mp3	http://localhost:8080/files/01.%20Eastern%20Dream%E3%80%80%EF%BD%9E%20The%20Introduction.mp3
15	02. The Venerable Ancient Battlefield ~ Suwa Foughten Field.mp3	http://localhost:8080/files/02.%20%C2%90The%20Venerable%20Ancient%20Battlefield%20~%20Suwa%20Foughten%20Field.mp3
16	03. Cemetery of Onbashira ~ Grave of the Shadow.mp3	http://localhost:8080/files/03.%20Cemetery%20of%20Onbashira%20~%20Grave%20of%20the%20Shadow.mp3
17	04. Lunar Clock ~ Luna Dial.mp3	http://localhost:8080/files/04.%20Lunar%20Clock%20~%20Luna%20Dial.mp3
18	05. Shanghai Scarlet Teahouse ~ Chinese Tea.mp3	http://localhost:8080/files/05.%20Shanghai%20Scarlet%20Teahouse%20~%20Chinese%20Tea.mp3
19	06. Tomboyish Girl in Love ~ killer Tune.mp3	http://localhost:8080/files/06.%20Tomboyish%20Girl%20in%20Love%20~%20killer%20Tune.mp3
20	07. Faith is for the Transient People ~ Jehovah's YaHVeH.mp3	http://localhost:8080/files/07.%20%C2%90Faith%20is%20for%20the%20Transient%20People%20~%20Jehovah's%20YaHVeH.mp3
21	08. Eastern Ghostly Dream ~ Ancient Temple.mp3	http://localhost:8080/files/08.%20Eastern%20Ghostly%20Dream%20~%20Ancient%20Temple.mp3
22	09. Spiritual Domination ~ Who done it!.mp3	http://localhost:8080/files/09.%20Spiritual%20Domination%20~%20Who%20done%20it!.mp3
23	10. Necrofantasia ~ Remix.mp3	http://localhost:8080/files/10.%20Necrofantasia%20~%20Remix.mp3
24	01 - Fee.mp3	http://localhost:8080/files/01%20-%20Fee.mp3
25	02 - Stigma.mp3	http://localhost:8080/files/02%20-%20Stigma.mp3
26	03 - Torikago.mp3	http://localhost:8080/files/03%20-%20Torikago.mp3
27	04 - Haru e.mp3	http://localhost:8080/files/04%20-%20Haru%20e.mp3
28	05 - Gekka Kyousou.mp3	http://localhost:8080/files/05%20-%20Gekka%20Kyousou.mp3
29	06 - Deep Sea.mp3	http://localhost:8080/files/06%20-%20Deep%20Sea.mp3
30	07 - Chinmoku no Mayu.mp3	http://localhost:8080/files/07%20-%20Chinmoku%20no%20Mayu.mp3
31	08 - Pray in the Darkness.mp3	http://localhost:8080/files/08%20-%20Pray%20in%20the%20Darkness.mp3
32	09 - Garden.mp3	http://localhost:8080/files/09%20-%20Garden.mp3
33	01. Foreground Eclipse - R.U..flac	http://localhost:8080/files/01.%20Foreground%20Eclipse%20-%20R.U..flac
34	02. Foreground Eclipse - Dear, Are You Getting Sober.flac	http://localhost:8080/files/02.%20Foreground%20Eclipse%20-%20Dear,%20Are%20You%20Getting%20Sober.flac
35	03. Foreground Eclipse - Last Liar Standing.flac	http://localhost:8080/files/03.%20Foreground%20Eclipse%20-%20Last%20Liar%20Standing.flac
36	04. Foreground Eclipse - Wandering, Never Wondering (There Exists A Shade).flac	http://localhost:8080/files/04.%20Foreground%20Eclipse%20-%20Wandering,%20Never%20Wondering%20(There%20Exists%20A%20Shade).flac
37	05. Foreground Eclipse - Truths, Ironies, The Secret Lyrics.flac	http://localhost:8080/files/05.%20Foreground%20Eclipse%20-%20Truths,%20Ironies,%20The%20Secret%20Lyrics.flac
38	06. Foreground Eclipse - (I Don't Need Any Titles To This Song!).flac	http://localhost:8080/files/06.%20Foreground%20Eclipse%20-%20(I%20Don't%20Need%20Any%20Titles%20To%20This%20Song!).flac
39	07. Foreground Eclipse - From Under Cover (Caught Up In A Love Song).flac	http://localhost:8080/files/07.%20Foreground%20Eclipse%20-%20From%20Under%20Cover%20(Caught%20Up%20In%20A%20Love%20Song).flac
40	08. Foreground Eclipse - Storytellers.flac	http://localhost:8080/files/08.%20Foreground%20Eclipse%20-%20Storytellers.flac
41	09. Foreground Eclipse - Koi no Twinkle Dance.flac	http://localhost:8080/files/09.%20Foreground%20Eclipse%20-%20Koi%20no%20Twinkle%C2%81%20Dance.flac
42	01. 幻視の夜 ～ Ghostly Eyes.mp3	http://localhost:8080/files/01.%20%E5%B9%BB%E8%A6%96%E3%81%AE%E5%A4%9C%20%EF%BD%9E%20Ghostly%20Eyes.mp3
43	02. 優雅に咲かせ、墨染の桜 ～ Border of Life.mp3	http://localhost:8080/files/02.%20%E5%84%AA%E9%9B%85%E3%81%AB%E5%92%B2%E3%81%8B%E3%81%9B%E3%80%81%E5%A2%A8%E6%9F%93%E3%81%AE%E6%A1%9C%20%EF%BD%9E%20Border%20of%20Life.mp3
44	03. 風の循環 ～ Wind Tour.mp3	http://localhost:8080/files/03.%20%E9%A2%A8%E3%81%AE%E5%BE%AA%E7%92%B0%20%EF%BD%9E%20Wind%20Tour.mp3
45	04. 無何有の郷 ～ Deep Mountain.mp3	http://localhost:8080/files/04.%20%E7%84%A1%E4%BD%95%E6%9C%89%E3%81%AE%E9%83%B7%20%EF%BD%9E%20Deep%20Mountain.mp3
46	05. 東の国の眠らない夜.mp3	http://localhost:8080/files/05.%20%E6%9D%B1%E3%81%AE%E5%9B%BD%E3%81%AE%E7%9C%A0%E3%82%89%E3%81%AA%E3%81%84%E5%A4%9C.mp3
47	06. メイドと血の懐中時計.mp3	http://localhost:8080/files/06.%20%E3%83%A1%E3%82%A4%E3%83%89%E3%81%A8%E8%A1%80%E3%81%AE%E6%87%90%E4%B8%AD%E6%99%82%E8%A8%88.mp3
48	07. さくらさくら ～ Japanize Dream.mp3	http://localhost:8080/files/07.%20%E3%81%95%E3%81%8F%E3%82%89%E3%81%95%E3%81%8F%E3%82%89%20%EF%BD%9E%20Japanize%20Dream.mp3
49	08. 紅楼 ～ Eastern Dream.mp3	http://localhost:8080/files/08.%20%E7%B4%85%E6%A5%BC%20%EF%BD%9E%20Eastern%20Dream.mp3
50	01. Crazy Xenomorph.mp3	http://localhost:8080/files/01.%20Crazy%20Xenomorph.mp3
51	02. Bridge of The Lotus.mp3	http://localhost:8080/files/02.%20Bridge%20of%20The%20Lotus.mp3
52	03. Innumerable Eyes.mp3	http://localhost:8080/files/03.%20Innumerable%20Eyes.mp3
53	04. Nuclear Fusion.mp3	http://localhost:8080/files/04.%20Nuclear%20Fusion.mp3
54	05. Dance of puNDarika.mp3	http://localhost:8080/files/05.%20Dance%20of%20puNDarika.mp3
55	06. World's End.mp3	http://localhost:8080/files/06.%20World's%20End.mp3
56	07. Silent Voyage to Eternity.mp3	http://localhost:8080/files/07.%20Silent%20Voyage%20to%20Eternity.mp3
57	08. Flame for Puja.mp3	http://localhost:8080/files/08.%20Flame%20for%20Puja.mp3
58	09. View of The River Styx.mp3	http://localhost:8080/files/09.%20View%20of%20The%20River%20Styx.mp3
59	01. Foreground Eclipse - You Can't Explain Anything Without The Word 'Destruction'.flac	http://localhost:8080/files/01.%20Foreground%20Eclipse%20-%20You%20Can't%20Explain%20Anything%20Without%20The%20Word%20'Destruction'.flac
60	02. Foreground Eclipse - Destruction.flac	http://localhost:8080/files/02.%20Foreground%20Eclipse%20-%20Destruction.flac
61	03. Foreground Eclipse - Obstruction! Color It All Out.flac	http://localhost:8080/files/03.%20Foreground%20Eclipse%20-%20Obstruction!%20Color%20It%20All%20Out.flac
62	04. Foreground Eclipse - I Bet You'll Forget That Even If You Noticed That.flac	http://localhost:8080/files/04.%20Foreground%20Eclipse%20-%20I%20Bet%20You'll%20Forget%20That%20Even%20If%20You%20Noticed%20That.flac
63	05. Foreground Eclipse - Nooneness Is For Danger.flac	http://localhost:8080/files/05.%20Foreground%20Eclipse%20-%20Nooneness%20Is%20For%20Danger.flac
64	06. Foreground Eclipse - Things What Fowls Can't See Confuse Us.flac	http://localhost:8080/files/06.%20Foreground%20Eclipse%20-%20Things%20What%20Fowls%20Can't%20See%20Confuse%20Us.flac
65	07. Foreground Eclipse - Noble.flac	http://localhost:8080/files/07.%20Foreground%20Eclipse%20-%20Noble.flac
66	08. Foreground Eclipse - If You Feel Like Sinking Down.flac	http://localhost:8080/files/08.%20Foreground%20Eclipse%20-%20If%20You%20Feel%20Like%20Sinking%20Down.flac
67	09. Foreground Eclipse - Escapes.flac	http://localhost:8080/files/09.%20Foreground%20Eclipse%20-%20Escapes.flac
68	10. Foreground Eclipse - ‚Ç‚ç‚Ô.flac	http://localhost:8080/files/10.%20Foreground%20Eclipse%20-%20%E2%80%9A%C3%87%E2%80%9A%C3%A7%E2%80%9A%C3%94.flac
69	Tapestry Of The Starless Abstract.mp3	http://localhost:8080/files/Tapestry%20Of%20The%20Starless%20Abstract.mp3
70	Xenoflux.mp3	http://localhost:8080/files/Xenoflux.mp3
71	Of The Leper Butterflies.mp3	http://localhost:8080/files/Of%20The%20Leper%20Butterflies.mp3
72	Forget Not.mp3	http://localhost:8080/files/Forget%20Not.mp3
73	And Plague Flowers The Kaleidoscope.mp3	http://localhost:8080/files/And%20Plague%20Flowers%20The%20Kaleidoscope.mp3
74	As Icicles Fall.mp3	http://localhost:8080/files/As%20Icicles%20Fall.mp3
75	Of Petrichor Weaves Black Noise.mp3	http://localhost:8080/files/Of%20Petrichor%20Weaves%20Black%20Noise.mp3
76	01. TRäkker — Somersault.mp3	http://localhost:8080/files/01.%20TR%C3%A4kker%20%E2%80%94%20Somersault.mp3
77	02. TRäkker — Rootus.mp3	http://localhost:8080/files/02.%20TR%C3%A4kker%20%E2%80%94%20Rootus.mp3
78	03. TRäkker — Future & Aquarium (TRäkker Ver).mp3	http://localhost:8080/files/03.%20TR%C3%A4kker%20%E2%80%94%20Future%20&%20Aquarium%20(TR%C3%A4kker%20Ver).mp3
79	04. TRäkker — Heaven's Fall (zts Remix).mp3	http://localhost:8080/files/04.%20TR%C3%A4kker%20%E2%80%94%20Heaven's%20Fall%20(zts%20Remix).mp3
80	01-Introduction.mp3	http://localhost:8080/files/01-Introduction.mp3
81	02-Heaven's Fall.mp3	http://localhost:8080/files/02-Heaven's%20Fall.mp3
82	03-Stage the Lives.mp3	http://localhost:8080/files/03-Stage%20the%20Lives.mp3
83	04-Contdown to the Blue.mp3	http://localhost:8080/files/04-Contdown%20to%20the%20Blue.mp3
84	05-Standard Unison.mp3	http://localhost:8080/files/05-Standard%20Unison.mp3
85	06-Unmapped.mp3	http://localhost:8080/files/06-Unmapped.mp3
86	07-Outsider.mp3	http://localhost:8080/files/07-Outsider.mp3
87	08-Separate Wings.mp3	http://localhost:8080/files/08-Separate%20Wings.mp3
88	09-The Inner Gaze -Will-.mp3	http://localhost:8080/files/09-The%20Inner%20Gaze%20-Will-.mp3
89	10-Trail of Dust.mp3	http://localhost:8080/files/10-Trail%20of%20Dust.mp3
90	11-Insaniy -Rebirth-.mp3	http://localhost:8080/files/11-Insaniy%20-Rebirth-.mp3
91	12-The Inner Gaze.mp3	http://localhost:8080/files/12-The%20Inner%20Gaze.mp3
\.


--
-- Data for Name: tb_genres; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_genres (id_genre, description) FROM stdin;
1	Dream Pop
2	Shoegaze
3	Instrumental
4	Heavy Metal
5	J-Pop
6	Symphonic Metal
7	Post-Hardcore
8	Melodic Metalcore
9	Trance
10	Drum and Bass
\.


--
-- Data for Name: tb_playlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_playlists (id_playlist, playlist_name, fk_user) FROM stdin;
1	Playlist 1	1
\.


--
-- Data for Name: tb_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_roles (id, role_name) FROM stdin;
1	ROLE_USER
2	ROLE_MODERATOR
3	ROLE_ADMIN
\.


--
-- Data for Name: tb_songs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_songs (id_song, song_length, song_title, fk_album, fk_file) FROM stdin;
1	0	Conservation of Two	1	1
2	0	Air Supply	1	2
3	0	Forever	1	3
4	0	Acting	1	4
5	0	Milk	1	5
6	0	Darkness	1	6
7	0	To the Moon	1	7
8	0	Song about a Sea	1	8
9	0	Song about a Sun	1	9
10	0	No Words to Be Found	1	10
11	0	Pretending	1	11
12	0	Misfortunes are Cruel	1	12
13	0	Your World is Eternally Complete	1	13
14	0	Eastern Dream ~ The Introduction	2	14
15	0	神さびた古戦場 ~ Suwa Foughten Field	2	15
16	0	御柱の墓場 ~ Grave of the Shadow	2	16
17	0	月時計 ~ ルナ・ダイアル	2	17
18	0	上海紅茶館 ~ Chinese Tea	2	18
19	0	おてんば恋娘 ~ killer Tune	2	19
20	0	信仰は儚き人間の為に ~ Jehovah's YaHVeH	2	20
21	0	東方妖々夢 ~ Ancient Temple	2	21
22	0	妖々跋扈 ~ Who done it！	2	22
23	0	ネクロファンタジア ～ Remix	2	23
24	0	Fee	3	24
25	0	Stigma	3	25
26	0	Torikago	3	26
27	0	Haru e	3	27
28	0	Gekka Kyousou	3	28
29	0	Deep Sea	3	29
30	0	Chinmoku no Mayu	3	30
31	0	Pray in the Darkness	3	31
32	0	Garden	3	32
33	0	R.U.	4	33
34	0	Dear, Are You Getting Sober	4	34
35	0	Last Liar Standing	4	35
36	0	Wandering, Never Wondering	4	36
37	0	Truths, Ironies, The Secret Lyrics	4	37
38	0	(I Don't Need Any Titles To This Song!)	4	38
39	0	From Under Cover (Caught Up In a Love Song)	4	39
40	0	Storytellers	4	40
41	0	恋のTwinkle☆Dance	4	41
42	0	幻視の夜 ～ Ghostly Eyes	5	42
43	0	優雅に咲かせ、墨染の桜 ～ Border of Life	5	43
44	0	風の循環 ～ Wind Tour	5	44
45	0	無何有の郷 ～ Deep Mountain	5	45
46	0	東の国の眠らない夜	5	46
47	0	メイドと血の懐中時計	5	47
48	0	さくらさくら ～ Japanize Dream	5	48
49	0	紅楼 ～ Eastern Dream	5	49
50	0	平安のエイリアン ～ Crazy Xenomorph	6	50
51	0	天空の花の都 ～ Bridge of The Lotus	6	51
52	0	少女さとり　～ Innumerable Eyes	6	52
53	0	霊知の太陽信仰　～ Nuclear Fusion	6	53
54	0	少女が見た日本の原風景 ～ Dance of puNDarika	6	54
55	0	感情の魔天楼　～ World's End	6	55
56	0	春の湊に ～ Silent Voyage to Eternity	6	56
57	0	法界の火 ～ Flame for Puja	6	57
58	0	彼岸帰航 ～ View of The River Styx	6	58
59	0	You Can't Explain Anything Without The Word 'Destruction'	7	59
60	0	Destruction	7	60
61	0	Obstruction! Color It All Out	7	61
62	0	I Bet You'll Forget That Even If You Noticed That	7	62
63	0	Nooneness Is For Danger	7	63
64	0	Things What Fowls Can't See Confuse Us	7	64
65	0	Noble	7	65
66	0	If You Feel Like Sinking Down	7	66
67	0	Escapes	7	67
68	0	どらぶ	7	68
69	0	Tapestry of the Starless Abstract	8	69
70	0	Xenoflux	8	70
71	0	Of the Leper Butterflies	8	71
72	0	Forget Not	8	72
73	0	And Plague Flowers the Kaleidoscope	8	73
74	0	As Icicles Fall	8	74
75	0	Of Petrichor Weaves Black Noise	8	75
76	0	Somersault	10	76
77	0	Rootus	10	77
78	0	Future & Aquarium (TRäkker ver.)	10	78
79	0	Heaven's Fall (zts remix)	10	79
80	0	Introduction	9	80
81	0	Heaven's Fall	9	81
82	0	Stage the Lives	9	82
83	0	Countdown to the Blue	9	83
84	0	Standard Unison	9	84
85	0	Unmapped	9	85
86	0	Outsider	9	86
87	0	Separate Wings	9	87
88	0	The Inner Gaze -Will-	9	88
89	0	Trail of Dust	9	89
90	0	Insanity -Rebirth-	9	90
91	0	The Inner Gaze	9	91
\.


--
-- Data for Name: tb_songs_album; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_songs_album (fk_song, fk_album) FROM stdin;
\.


--
-- Data for Name: tb_songs_playlist; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_songs_playlist (fk_playlist, fk_song) FROM stdin;
1	2
1	12
1	15
\.


--
-- Data for Name: tb_user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_user_roles (fk_user, fk_role) FROM stdin;
1	1
1	2
1	3
\.


--
-- Data for Name: tb_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tb_users (id_user, email, password, username) FROM stdin;
1	test@mail.com	$2a$10$dWcfKaUfufIpMqom1Vxije2fWi.1IluXFQAxbFBS9af2xP1yX.g22	test
\.


--
-- Name: tb_albums_id_album_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_albums_id_album_seq', 10, true);


--
-- Name: tb_artists_id_artist_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_artists_id_artist_seq', 6, true);


--
-- Name: tb_files_id_file_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_files_id_file_seq', 91, true);


--
-- Name: tb_genres_id_genre_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_genres_id_genre_seq', 10, true);


--
-- Name: tb_playlists_id_playlist_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_playlists_id_playlist_seq', 1, true);


--
-- Name: tb_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_roles_id_seq', 1, false);


--
-- Name: tb_songs_id_song_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tb_songs_id_song_seq', 91, true);


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
-- Name: tb_files tb_files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_files
    ADD CONSTRAINT tb_files_pkey PRIMARY KEY (id_file);


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
-- Name: tb_songs uk_rcbcpgcthsdgaeape49yaayxm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs
    ADD CONSTRAINT uk_rcbcpgcthsdgaeape49yaayxm UNIQUE (fk_file);


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
-- Name: tb_songs fk7xor8wx7qbg9gldyn9pnsacve; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tb_songs
    ADD CONSTRAINT fk7xor8wx7qbg9gldyn9pnsacve FOREIGN KEY (fk_file) REFERENCES public.tb_files(id_file);


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
