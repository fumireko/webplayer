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

@Injectable({
  providedIn: 'root'
})
export class ApiService {

  constructor(private http: HttpClient) { }

  getArtists(): Observable<Artist[]> {
    return this.http.get<Artist[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/artists/', { withCredentials: false });
  }

  getAlbums(): Observable<Album[]> {
    return this.http.get<Artist[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/albums/', { withCredentials: false });
  }

  getGenres(): Observable<Genre[]> {
    return this.http.get<Genre[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/genres/', { withCredentials: false });
  }

  getPlaylists(): Observable<Playlist[]> {
    return this.http.get<Playlist[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/playlists/', { withCredentials: false });
  }

  getSongs(): Observable<Song[]> {
    return this.http.get<Song[]>(AppComponent.PUBLIC_BACKEND_URL + '/api/songs/', { withCredentials: false });
  }

  getFiles(): Observable<File[]> {
    return this.http.get<File[]>(AppComponent.PUBLIC_BACKEND_URL + '/files/', { withCredentials: false });
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

  saveAlbum(a: Album): Observable<Album> {
    return this.http.post<Album>(`${AppComponent.PUBLIC_BACKEND_URL}/api/albums/`, a, { withCredentials: false});
  }

  saveArtist(a: Artist): Observable<Artist> {
    return this.http.post<Artist>(`${AppComponent.PUBLIC_BACKEND_URL}/api/artists/`, a, { withCredentials: false});
  }

  saveSong(song: Song): Observable<Song> {
    return this.http.post<Song>(`${AppComponent.PUBLIC_BACKEND_URL}/api/songs/`, song, { withCredentials: false });
  }
  
}