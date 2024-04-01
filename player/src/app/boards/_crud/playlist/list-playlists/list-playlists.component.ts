import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Playlist } from '../../../../shared/models/playlist.model';
import { Song } from '../../../../shared/models/song.model';
import { User } from '../../../../shared/models/user.model'; // Import User model if not already imported

@Component({
  selector: 'app-list-playlists',
  templateUrl: './list-playlists.component.html',
  styleUrls: ['./list-playlists.component.css']
})
export class ListPlaylistsComponent {

  selectedPlaylist: Playlist | undefined;
  newPlaylist: Playlist = new Playlist();
  newSong: Song = new Song();
  addSongToggle: boolean = false;
  playlists: Playlist[] = [];
  songs: Song[] = [];
  users: User[] = [];
  newPlaylistToggle: boolean = false;

  constructor(private http: ApiService) { }

  ngOnInit() {
    this.http.getPlaylists().subscribe((data: Playlist[]) => {
      this.playlists = data;
    });
    this.http.getSongs().subscribe((data: Song[]) => {
      this.songs = data;
    });
    this.http.getUsers().subscribe((data: User[]) => {
      this.users = data;
    });
  }

  showDetails(playlist: Playlist) {
    this.selectedPlaylist = playlist;
  }

  toggleAddSong() {
    this.addSongToggle = !this.addSongToggle;
  }

  addSong() {
    if (this.selectedPlaylist) {
      this.selectedPlaylist.songs?.push(this.newSong);
      this.savePlaylist();
    }
  }

  // Define toggleNewPlaylist method
  toggleNewPlaylist() {
    this.newPlaylistToggle = !this.newPlaylistToggle;
  }

  saveNewPlaylist() {
    this.http.savePlaylist(this.newPlaylist).subscribe((playlist: Playlist) => {
      this.playlists.push(playlist);
      this.resetEdit();
    });
  }

  savePlaylist() {
    if (this.selectedPlaylist) {
      this.http.updatePlaylist(this.selectedPlaylist).subscribe((playlist: Playlist) => {
        this.selectedPlaylist = playlist;
        this.resetEdit();
      });
    }
  }

  filterSongs(): Song[] {
    if (!this.selectedPlaylist || !this.selectedPlaylist.songs) {
      return this.songs;
    }
    return this.songs.filter(song => !this.selectedPlaylist!.songs!.some(s => s.id === song.id));
  }

  resetEdit() {
    this.addSongToggle = false;
    this.newPlaylistToggle = false;
    this.newPlaylist = new Playlist();
    this.newSong = new Song();
  }
}
