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
    this.audio.src = this.getCurrentSong().file?.url!;
    this.audio.load();
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

  getCurrentSong(): Song {
    return this.queue[this.currentSongIndex];
  }
}