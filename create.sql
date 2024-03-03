CREATE TABLE IF NOT EXISTS tb_artists (
    id_artist SERIAL PRIMARY KEY,
    artist_name VARCHAR(512) NOT NULL UNIQUE,
    description TEXT, 
    country_code CHAR(2)
);

CREATE TABLE IF NOT EXISTS tb_albums (
    id_album SERIAL PRIMARY KEY,
    album_title VARCHAR(512) NOT NULL,
	album_image_url VARCHAR(512),
    release_date TIMESTAMP,
    fk_artist INTEGER,
    FOREIGN KEY (fk_artist) REFERENCES tb_artists(id_artist) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tb_roles (
    id_role SERIAL PRIMARY KEY,
    role_name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS tb_users (
    id_user SERIAL PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_user_roles (
    fk_user INT,
    fk_role INT,
    FOREIGN KEY (fk_user) REFERENCES tb_users(id_user) ON DELETE CASCADE,
    FOREIGN KEY (fk_role) REFERENCES tb_roles(id_role) ON DELETE CASCADE,
    PRIMARY KEY (fk_user, fk_role)
);

CREATE TABLE IF NOT EXISTS tb_songs (
    id_song SERIAL PRIMARY KEY,
    song_title VARCHAR(512),
    song_length INTEGER,
    fk_album INTEGER,
    FOREIGN KEY (fk_album) REFERENCES tb_albums(id_album) ON DELETE CASCADE
);	

CREATE TABLE IF NOT EXISTS tb_playlists (
    id_playlist SERIAL PRIMARY KEY,
    playlist_name VARCHAR(100),
    fk_user INT,
    FOREIGN KEY (fk_user) REFERENCES tb_users(id_user) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tb_genres (
    id_genre SERIAL PRIMARY KEY,
    description VARCHAR(128) UNIQUE
);

CREATE TABLE IF NOT EXISTS tb_songs_album (
    fk_song INT,
    fk_album INT,
    PRIMARY KEY (fk_song, fk_album),
    FOREIGN KEY (fk_song) REFERENCES tb_songs(id_song) ON DELETE CASCADE,
    FOREIGN KEY (fk_album) REFERENCES tb_albums(id_album) ON DELETE CASCADE
);

	CREATE TABLE IF NOT EXISTS tb_albums_artist (
		fk_album INT,
		fk_artist INT,
		PRIMARY KEY (fk_album, fk_artist),
		FOREIGN KEY (fk_album) REFERENCES tb_albums(id_album) ON DELETE CASCADE,
		FOREIGN KEY (fk_artist) REFERENCES tb_artists(id_artist) ON DELETE CASCADE
	);

CREATE TABLE IF NOT EXISTS tb_songs_playlist (
    fk_song INT,
    fk_playlist INT,
    date_added TIMESTAMP,
    play_count INT,
    PRIMARY KEY (fk_song, fk_playlist),
    FOREIGN KEY (fk_song) REFERENCES tb_songs(id_song) ON DELETE CASCADE,
    FOREIGN KEY (fk_playlist) REFERENCES tb_playlists(id_playlist) ON DELETE CASCADE
);


CREATE TABLE IF NOT EXISTS tb_artists_genre (
    fk_artist INT,
    fk_genre INT,
    PRIMARY KEY (fk_artist, fk_genre),
    FOREIGN KEY (fk_artist) REFERENCES tb_artists(id_artist) ON DELETE CASCADE,
    FOREIGN KEY (fk_genre) REFERENCES tb_genres(id_genre) ON DELETE CASCADE
);

INSERT INTO public.tb_roles (id_role, role_name) VALUES (1, 'ROLE_USER');
INSERT INTO public.tb_roles (id_role, role_name) VALUES (2, 'ROLE_MODERATOR');
INSERT INTO public.tb_roles (id_role, role_name) VALUES (3, 'ROLE_ADMIN');

INSERT INTO public.tb_users (id_user, username, email, password) VALUES (1, 'test', 'test@mail.com', '$2a$10$dWcfKaUfufIpMqom1Vxije2fWi.1IluXFQAxbFBS9af2xP1yX.g22');

INSERT INTO public.tb_user_roles (fk_user, fk_role) VALUES (1, 1);
INSERT INTO public.tb_user_roles (fk_user, fk_role) VALUES (1, 2);
INSERT INTO public.tb_user_roles (fk_user, fk_role) VALUES (1, 3);