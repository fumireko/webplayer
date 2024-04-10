import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Album } from '../../shared/models/album.model';
import { MusicPlayerService } from '../../services/music-player.service';
import { Song } from '../../shared/models/song.model';
import { ApiService } from '../../services/api.service';
import { AppComponent } from '../../app.component';
import { StyleService } from '../../services/style.service';

@Component({
  selector: 'app-album-details',
  templateUrl: './album-details.component.html',
  styleUrls: ['./album-details.component.css']
})
export class AlbumDetailsComponent implements OnInit {
  album: Album | undefined;
  hoveredSong: Song = new Song();
  averageColor: string = "";

  constructor(
    private route: ActivatedRoute,
    private api: ApiService,
    private musicPlayerService: MusicPlayerService,
    private styleService: StyleService
  ){}

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
        this.api.getAlbumById(parseInt(params.get('id')!)).subscribe(a => {
          this.album = a;
          this.styleService.calculateAverageColor(this.album);
          this.styleService.averageColor.subscribe(c => this.averageColor = c);
        });
    });
  }

  setSong(s: Song){
    this.musicPlayerService.addToQueue(s);
    this.musicPlayerService.setCurrentSong(s);
  }

  addToQueue(s: Song){
    this.musicPlayerService.addToQueue(s);
  }
}
