import { Component } from '@angular/core';
import { UserService } from '../services/user.service';
import { MusicPlayerService } from '../services/music-player.service';
import { Song } from '../shared/models/song.model';
import { Album } from '../shared/models/album.model';
import { ApiService } from '../services/api.service';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  content?: string;
  currentSong?: Song;
  albums: Album[] = []

  selectedAlbum: Album = new Album();

  constructor(private http: ApiService,
              private userService: UserService,
              private musicPlayerService: MusicPlayerService) { }

  ngOnInit(): void {
    this.currentSong = this.musicPlayerService.getCurrentSong();

    this.http.getAlbums().subscribe((albums) => {
      this.albums = albums;
    })

    this.userService.getPublicContent().subscribe({
      next: data => {
        this.content = data;
      },
      error: err => {console.log(err)
        if (err.error) {
          this.content = JSON.parse(err.error).message;
        } else {
          this.content = "Error with status: " + err.status;
        }
      }
    });
  }

  showAlbum(a: Album){
    this.selectedAlbum = a;
  }

  formatDate(date: Date): string {
    console.log(date);
    return date.toString();
  }

  play() {
    this.musicPlayerService.play();
  }

  pause() {
    this.musicPlayerService.pause();
  }

  next() {
    this.musicPlayerService.next();
    this.currentSong = this.musicPlayerService.getCurrentSong();
  }

  previous() {
    this.musicPlayerService.previous();
    this.currentSong = this.musicPlayerService.getCurrentSong();
  }
}
