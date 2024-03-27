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
  private currentSongSubject: BehaviorSubject<Song | undefined> = new BehaviorSubject<Song | undefined>(undefined);

  constructor() { }

  addToQueue(song: Song) {
    this.queue.push(song);
  }

  play() {
    this.audio.play();
  }

  pause() {
    this.audio.pause();
  }

  next() {
    this.currentSongIndex = (this.currentSongIndex + 1) % this.queue.length;
    this.updateCurrentSong();
    this.play();
  }

  previous() {
    this.currentSongIndex = (this.currentSongIndex - 1 + this.queue.length) % this.queue.length;
    this.updateCurrentSong();
    this.play();
  }

  setCurrentSong(song: Song) {
    const index = this.queue.findIndex(item => item === song);
    if (index !== -1) {
      this.currentSongIndex = index;
      this.audio.src = song.file?.url!;
      this.audio.load();
      this.updateCurrentSong();
      this.play();
    }
  }

  getCurrentSongObservable(): Observable<Song | undefined> {
    return this.currentSongSubject.asObservable();
  }

  seekTo(time: number) {
    if (this.audio.duration) {
      this.audio.currentTime = time;
    }
  }

  getCurrentTime(): number {
    return this.audio.currentTime;
  }

  getTotalDuration(): number {
    return this.audio.duration;
  }

  changeVolume(volume: number) {
    if (volume >= 0 && volume <= 1) {
      this.audio.volume = volume;
    }
  }

  private updateCurrentSong() {
    const currentSong = this.queue[this.currentSongIndex];
    this.currentSongSubject.next(currentSong);
  }
}
