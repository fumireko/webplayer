import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription, interval } from 'rxjs';
import { MusicPlayerService } from '../../services/music-player.service';
import { Song } from '../../shared/models/song.model';

@Component({
  selector: 'app-player',
  templateUrl: './player.component.html',
  styleUrls: ['./player.component.css']
})
export class PlayerComponent implements OnInit, OnDestroy {
  currentSong: Song = new Song();
  currentTime: number = 0;
  totalDuration: number = 0;
  volume: number = 0.5;
  queue: Song[] = [];
  playing: boolean = false;

  private playerSubscription: Subscription | undefined;

  constructor(private musicPlayerService: MusicPlayerService) {}

  ngOnInit(): void {
    this.musicPlayerService.getCurrentSongObservable().subscribe(song => {
      if (song) {
        this.currentSong = song;
        this.totalDuration = this.musicPlayerService.getTotalDuration();
        this.queue = this.musicPlayerService.getQueue();
      }
    });

    this.playerSubscription = interval(1000).subscribe(() => {
      this.currentTime = this.musicPlayerService.getCurrentTime();
    });
  }

  ngOnDestroy(): void {
    if (this.playerSubscription) {
      this.playerSubscription.unsubscribe();
    }
  }

  playPause(): void {
    if (this.playing) {
      this.musicPlayerService.pause();
    } else {
      this.musicPlayerService.play();
    }
    this.playing = !this.playing;
  }

  next(): void {
    this.musicPlayerService.next();
  }

  previous(): void {
    this.musicPlayerService.previous();
  }

  onSeek(e: Event): void {
    if (e.target) this.musicPlayerService.seekTo(parseInt((<HTMLInputElement>e.target).value));
  }

  onVolumeChange(e: Event): void {
    if (e.target) this.musicPlayerService.changeVolume(parseInt((<HTMLInputElement>e.target).value));
  }
  
  formatTime(time: number): string {
    const minutes: number = Math.floor(time / 60);
    const seconds: number = Math.floor(time % 60);
    return `${minutes}:${seconds < 10 ? '0' : ''}${seconds}`;
  }
}
