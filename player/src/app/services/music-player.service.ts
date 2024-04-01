import { Injectable } from '@angular/core';
import { Song } from '../shared/models/song.model';
import { Observable, BehaviorSubject } from 'rxjs';

@Injectable({
  providedIn: 'root'
})
export class MusicPlayerService {
  private audio: HTMLAudioElement = new Audio();
  private queue: Song[] = [];
  private currentSongIndex = 0;
  private isPlaying: boolean = false;
  private currentSongSubject: BehaviorSubject<Song | undefined> = new BehaviorSubject<Song | undefined>(undefined);

  constructor() {
    this.audio.addEventListener('ended', () => this.next());
  }

  addToQueue(song: Song) {
    this.queue.push(song);
    if (this.queue.length === 1) {
      this.setCurrentSong(song);
    }
  }

  isPlayingBool() { return this.isPlaying }

  getQueue(): Song[] {
    return this.queue;
  }

  playPause() {
    if (this.isPlaying) {
      this.pause();
    } else {
      this.play();
    }
  }

  play() {
    if (this.queue.length === 0) return;
    this.audio.play();
    this.isPlaying = true;
  }

  pause() {
    this.audio.pause();
    this.isPlaying = false;
  }

  next() {
    if (this.queue.length === 0) return;
    this.currentSongIndex = (this.currentSongIndex + 1) % this.queue.length;
    this.setCurrentSong(this.queue[this.currentSongIndex]);
  }

  previous() {
    if (this.queue.length === 0) return;
    this.currentSongIndex = (this.currentSongIndex - 1 + this.queue.length) % this.queue.length;
    this.setCurrentSong(this.queue[this.currentSongIndex]);
  }

  setCurrentSong(song: Song) {
    const index = this.queue.indexOf(song);
    if (index !== -1) {
      this.currentSongIndex = index;
      this.audio.src = song.file?.url!;
      this.audio.load();
      this.play();
      this.updateCurrentSong();
    } else {
      console.error('Invalid song');
    }
  }

  getCurrentSongObservable(): Observable<Song | undefined> {
    return this.currentSongSubject.asObservable();
  }

  seekTo(time: number) {
    if (this.audio.duration && time >= 0 && time <= this.audio.duration) {
      this.audio.currentTime = time;
    } else {
      console.error('Invalid seek time');
    }
  }

  getCurrentTime(): number {
    if (!isNaN(this.audio.currentTime)) {
      return this.audio.currentTime;
    } else {
      console.error('Invalid current time');
      return 0;
    }
  }

  getTotalDuration(): number {
    if (!isNaN(this.audio.duration)) {
      return this.audio.duration;
    } else {
      this.audio.addEventListener('loadedmetadata', () => {
        this.currentSongSubject.next(this.queue[this.currentSongIndex]);
      });
      console.error('Invalid total duration');
      return 0;
    }
  }  

  changeVolume(volume: number) {
    if (volume >= 0 && volume <= 1) {
      this.audio.volume = volume;
    } else {
      console.error('Invalid volume');
    }
  }

  private updateCurrentSong() {
    const currentSong = this.queue[this.currentSongIndex];
    this.currentSongSubject.next(currentSong);
  }
}
