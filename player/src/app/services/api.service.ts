import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Artist } from '../shared/models/artist.model';
import { AppComponent } from '../app.component';
import { Album } from '../shared/models/album.model';
import { Genre } from '../shared/models/genre.model';
import { Playlist } from '../shared/models/playlist.model';
import { Song } from '../shared/models/song.model';
import { File } from '../shared/models/file.model';
import { User } from '../shared/models/user.model';

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  constructor(private http: HttpClient) { }

  getArtists(): Observable<Artist[]> {
    return this.http.get<Artist[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/artists/', { withCredentials: false });
  }
  
  getArtistSongs(id: number): Observable<Song[]> {
    return this.http.get<Song[]>(`${AppComponent.PUBLIC_BACKEND_URL}/api/artists/${id}/songs`, { withCredentials: false });
  }
  
  getArtistById(id: number): Observable<Artist> {
    return this.http.get<Artist>(`${AppComponent.PUBLIC_BACKEND_URL}/api/artists/${id}`, { withCredentials: false });
  }

  getAlbums(): Observable<Album[]> {
    return this.http.get<Artist[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/albums/', { withCredentials: false });
  }

  getAlbumById(id: number): Observable<Album> {
    return this.http.get<Album>(`${AppComponent.PUBLIC_BACKEND_URL}/api/albums/${id}`, { withCredentials: false });
  }

  getGenres(): Observable<Genre[]> {
    return this.http.get<Genre[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/genres/', { withCredentials: false });
  }

  getPlaylists(): Observable<Playlist[]> {
    return this.http.get<Playlist[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/playlists/', { withCredentials: false });
  }

  getPlaylistsByUserId(id: number): Observable<Playlist[]> {
    return this.http.get<Playlist[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/playlists/user/' + id, { withCredentials: false });
  }

  getSongs(): Observable<Song[]> {
    return this.http.get<Song[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/songs/', { withCredentials: false });
  }

  getFiles(): Observable<File[]> {
    return this.http.get<File[]>(AppComponent.PUBLIC_BACKEND_URL + '/files/', { withCredentials: false });
  }

  getUsers(): Observable<User[]> {
    return this.http.get<User[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/test/', { withCredentials: false });
  }

  updateSong(s: Song): Observable<Song> {
    return this.http.put<Song>(`${AppComponent.PUBLIC_BACKEND_URL}/api/songs/${s.id}`, s, { withCredentials: false });
  }
  
  updateAlbum(a: Album): Observable<Album> {
    return this.http.put<Album>(`${AppComponent.PUBLIC_BACKEND_URL}/api/albums/${a.id}`, a, { withCredentials: false });
  }  

  updateArtist(a: Artist): Observable<Artist> {
    return this.http.put<Artist>(`${AppComponent.PUBLIC_BACKEND_URL}/api/artists/${a.id}`, a, { withCredentials: false});
  }

  updatePlaylist(p: Playlist): Observable<Playlist> {
    return this.http.put<Playlist>(`${AppComponent.PUBLIC_BACKEND_URL}/api/playlists/${p.id}`, p, { withCredentials: false});
  }

  updateGenre(g: Genre): Observable<Genre> {
    return this.http.put<Genre>(`${AppComponent.PUBLIC_BACKEND_URL}/api/genres/${g.id}`, g, { withCredentials: false});
  }

  saveAlbum(a: Album): Observable<Album> {
    return this.http.post<Album>(`${AppComponent.PUBLIC_BACKEND_URL}/api/albums/`, a, { withCredentials: false});
  }

  saveArtist(a: Artist): Observable<Artist> {
    return this.http.post<Artist>(`${AppComponent.PUBLIC_BACKEND_URL}/api/artists/`, a, { withCredentials: false});
  }

  saveSong(song: Song): Observable<Song> {
    return this.http.post<Song>(`${AppComponent.PUBLIC_BACKEND_URL}/api/songs/`, song, { withCredentials: false });
  }
  
  savePlaylist(p: Playlist): Observable<Playlist> {
    return this.http.post<Playlist>(`${AppComponent.PUBLIC_BACKEND_URL}/api/playlists/`, p, { withCredentials: false });
  }

  saveGenre(g: Genre): Observable<Genre> {
    return this.http.post<Genre>(`${AppComponent.PUBLIC_BACKEND_URL}/api/genres/`, g, { withCredentials: false });
  }
}