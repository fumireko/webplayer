import { Component, OnInit, OnDestroy } from '@angular/core';
import { Subscription, interval } from 'rxjs';
import { MusicPlayerService } from '../../services/music-player.service';
import { Song } from '../../shared/models/song.model';
import { NgbModal } from '@ng-bootstrap/ng-bootstrap';
import { QueueComponent } from './queue/queue.component';

@Component({
  selector: 'app-player',
  templateUrl: './player.component.html',
  styleUrls: ['./player.component.css']
})
export class PlayerComponent implements OnInit, OnDestroy {
  currentSong: Song = new Song();
  currentTime = 0;
  totalDuration = 0;
  volume = 0.5;
  queue: Song[] = [];
  playing = true;
  playerSubscription: Subscription | undefined;
  isShuffled: boolean = false;
  isRepeated: boolean = false;

  constructor(private musicPlayerService: MusicPlayerService,
              private modalService: NgbModal) {}

  ngOnInit(): void {
    this.playerSubscription = interval(1000).subscribe(() => {
      this.currentTime = this.musicPlayerService.getCurrentTime();
    });

    this.musicPlayerService.getCurrentSongObservable().subscribe(song => {
      console.log(song);
      if (song) {
        this.currentSong = song;
        this.totalDuration = this.musicPlayerService.getTotalDuration();
        this.queue = this.musicPlayerService.getQueue();
      }
    });
  }

  ngOnDestroy(): void {
    this.playerSubscription?.unsubscribe();
  }

  playPause(): void {
    this.playing ? this.musicPlayerService.pause() : this.musicPlayerService.play();
    this.playing = this.musicPlayerService.isPlayingBool();
  }

  next(): void {
    this.musicPlayerService.next();
  }

  previous(): void {
    this.musicPlayerService.previous();
  }

  onSeek(event: Event): void {
    const target = event.target as HTMLInputElement;
    this.musicPlayerService.seekTo(parseInt(target.value));
  }

  onVolumeChange(event: Event): void {
    const target = event.target as HTMLInputElement;
    this.musicPlayerService.changeVolume(parseInt(target.value));
  }

  handleMute(): void { 
    this.musicPlayerService.changeVolume(this.volume === 0 ? 0.5 : 0);
  }

  toggleShuffle(): void {
    this.musicPlayerService.shuffle();
    this.isShuffled = !this.isShuffled;
  }

  toggleRepeat(): void {
    this.musicPlayerService.repeat();
    this.isRepeated = !this.isRepeated;
  }
  
  formatTime(time: number): string {
    const minutes = Math.floor(time / 60);
    const seconds = Math.floor(time % 60);
    return time !== 0 ? `${minutes}:${seconds < 10 ? '0' : ''}${seconds}` : '-';
  }

  showQueue(): void {
    const modalRef = this.modalService.open(QueueComponent);
    modalRef.componentInstance.queue = this.queue;
    modalRef.componentInstance.removeSong.subscribe((song: Song) => {
      this.musicPlayerService.removeFromQueue(song);
    });
  }
}
