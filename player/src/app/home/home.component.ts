import { Component } from '@angular/core';
import { UserService } from '../services/user.service';
import { MusicPlayerService } from '../services/music-player.service';
import { Song } from '../shared/models/song.model';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrl: './home.component.css'
})
export class HomeComponent {
  content?: string;
  currentSong?: Song;

  constructor(private userService: UserService,
              private musicPlayerService: MusicPlayerService) { }

  ngOnInit(): void {
    this.currentSong = this.musicPlayerService.getCurrentSong();
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
