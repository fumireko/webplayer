import { Component, OnDestroy } from '@angular/core';
import { Song } from '../../shared/models/song.model';
import { Album } from '../../shared/models/album.model';
import { ApiService } from '../../services/api.service';
import { UserService } from '../../services/user.service';
import { MusicPlayerService } from '../../services/music-player.service';
import { Subscription, interval } from 'rxjs';

@Component({
  selector: 'app-player',
  templateUrl: './player.component.html',
  styleUrls: ['./player.component.css']
})
export class PlayerComponent implements OnDestroy {
  content?: string;
  currentSong?: Song;
  albums: Album[] = [];

  selectedAlbum: Album = new Album();
  isPlaying: boolean = false;
  currentTime: number = 0;
  volume: number = 0.50;

  private timerSubscription: Subscription | undefined;
  private songSubscription: Subscription | undefined;

  constructor(private http: ApiService,
              private userService: UserService,
              private musicPlayerService: MusicPlayerService) { }

  ngOnInit(): void {
    this.songSubscription = this.musicPlayerService.getCurrentSongObservable().subscribe(song => {
      this.currentSong = song;
    });

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
    if (this.timerSubscription) {
      this.timerSubscription.unsubscribe();
    }
    if (this.songSubscription) {
      this.songSubscription.unsubscribe();
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
  }

  previous() {
    this.musicPlayerService.previous();
  }

  seekTo(event: Event) {
    this.musicPlayerService.seekTo((event.target as HTMLInputElement).valueAsNumber);
  }

  setSong(s: Song){
    this.musicPlayerService.addToQueue(s);
    this.musicPlayerService.setCurrentSong(s);
    this.isPlaying = true;
  }

  getCurrentTime(): void {
    this.currentTime = this.musicPlayerService.getCurrentTime();
  }

  getTotalTime(): number {
    return this.musicPlayerService.getTotalDuration();
  }

  changeVolume(){
    this.musicPlayerService.changeVolume(this.volume);
  }

  addToQueue(s: Song){
    this.musicPlayerService.addToQueue(s);
  }
}
