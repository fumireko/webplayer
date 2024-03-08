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
