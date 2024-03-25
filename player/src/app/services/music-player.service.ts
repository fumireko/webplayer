import { Injectable } from '@angular/core';
import { Song } from '../shared/models/song.model';

@Injectable({
  providedIn: 'root'
})
export class MusicPlayerService {
  private audio: HTMLAudioElement = new Audio();
  private queue: Song[] = [];
  private currentSongIndex = 0;

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
    this.play();
  }

  previous() {
    this.currentSongIndex = (this.currentSongIndex - 1 + this.queue.length) % this.queue.length;
    this.play();
  }

  setCurrentSong(song: Song) {
    const index = this.queue.findIndex(item => item === song);
    if (index !== -1) {
      this.currentSongIndex = index;
      this.audio.src = song.file?.url!;
      this.audio.load();
      this.play();
    }
  }

  getCurrentSong(): Song {
    return this.queue[this.currentSongIndex];
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
}
