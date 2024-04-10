import { Component, OnDestroy, OnInit } from '@angular/core';
import { UserService } from '../services/user.service';
import { MusicPlayerService } from '../services/music-player.service';
import { Song } from '../shared/models/song.model';
import { Album } from '../shared/models/album.model';
import { ApiService } from '../services/api.service';
import { Subscription } from 'rxjs';
import { Playlist } from '../shared/models/playlist.model';
import { StorageService } from '../services/storage.service';
import { Router } from '@angular/router';
import { StyleService } from '../services/style.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css']
})
export class HomeComponent implements OnInit {
  content?: string;
  currentSong?: Song;
  albums: Album[] = [];
  selectedAlbum: Album = new Album();
  isPlaying: boolean = false;
  currentTime: number = 0;
  volume: number = 0.50;
  playlists: Playlist[] = [];
  averageColor: any;

  constructor(private http: ApiService,
              private userService: UserService,
              private router: Router,
              private styleService: StyleService,
              private musicPlayerService: MusicPlayerService) { }

  ngOnInit(): void {
    //this.http.getPlaylistsByUserId(this.storageService.getUser().id).subscribe(e => {
    this.http.getPlaylists().subscribe(e => {
      this.playlists = e;
    })

    this.http.getAlbums().subscribe((albums) => {
      this.albums = albums;
    });

    this.userService.getPublicContent().subscribe({
      next: data => {
        this.content = data;
      },
      error: err => {
        console.log(err);
        if (err.error) {
          this.content = JSON.parse(err.error).message;
        } else {
          this.content = "Error with status: " + err.status;
        }
      }
    });

    this.musicPlayerService.getCurrentSongObservable().subscribe(song => {
      this.currentSong = song;
    });

    this.styleService.averageColor.subscribe(c => this.averageColor = c);
  }

  showAlbum(album: Album) {
    this.router.navigate(['/albums', album.id]);
  }  

  setSong(s: Song){
    this.musicPlayerService.addToQueue(s);
    this.musicPlayerService.setCurrentSong(s);
    this.isPlaying = true;
  }

  addToQueue(s: Song){
    this.musicPlayerService.addToQueue(s);
  }
}
