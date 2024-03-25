import { Component } from '@angular/core';
import { UserService } from '../services/user.service';
import { MusicPlayerService } from '../services/music-player.service';
import { Song } from '../shared/models/song.model';
import { Album } from '../shared/models/album.model';
import { ApiService } from '../services/api.service';
import { Subscription, interval } from 'rxjs';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.css'] // Corrected 'styleUrl' to 'styleUrls'
})
export class HomeComponent {
  content?: string;
  currentSong?: Song;
  albums: Album[] = [];

  selectedAlbum: Album = new Album();
  isPlaying: boolean = false;
  currentTime: number = 0;

  private timerSubscription: Subscription | undefined;
  
  constructor(private http: ApiService,
              private userService: UserService,
              private musicPlayerService: MusicPlayerService) { }

  ngOnInit(): void {
    this.currentSong = this.musicPlayerService.getCurrentSong();

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
    this.timerSubscription = interval(499).subscribe(() => {
      this.getCurrentTime();
    });
  }

  ngOnDestroy(): void {
    // Unsubscribe from the timerSubscription to prevent memory leaks
    if (this.timerSubscription) {
      this.timerSubscription.unsubscribe();
    }
  }

  showAlbum(a: Album){
    this.selectedAlbum = a;
  }

  playPause() {
    if (this.isPlaying) {
      this.pause();
    } else {
      this.play();
    }
  }

  play() {
    this.musicPlayerService.play();
    this.isPlaying = true;
  }

  pause() {
    this.musicPlayerService.pause();
    this.isPlaying = false;
  }

  next() {
    this.musicPlayerService.next();
    this.currentSong = this.musicPlayerService.getCurrentSong();
  }

  previous() {
    this.musicPlayerService.previous();
    this.currentSong = this.musicPlayerService.getCurrentSong();
  }

  seekTo(event: Event) {
    this.musicPlayerService.seekTo((event.target as HTMLInputElement).valueAsNumber);
  }

  setSong(s: Song){
    this.musicPlayerService.addToQueue(s);
    this.musicPlayerService.setCurrentSong(s);
    this.isPlaying = true;
    this.currentSong = this.musicPlayerService.getCurrentSong();
    console.log(this.musicPlayerService.getCurrentSong());
  }

  getCurrentTime(): number {
    return this.currentTime = this.musicPlayerService.getCurrentTime();
  }

  getTotalTime(): number {
    return this.musicPlayerService.getTotalDuration();
  }
}
