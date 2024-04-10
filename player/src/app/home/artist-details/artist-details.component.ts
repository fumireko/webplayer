import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ApiService } from '../../services/api.service';
import { MusicPlayerService } from '../../services/music-player.service';
import { Artist } from '../../shared/models/artist.model';
import { Song } from '../../shared/models/song.model';
import { Album } from '../../shared/models/album.model';
import { StyleService } from '../../services/style.service';

@Component({
  selector: 'app-artist-details',
  templateUrl: './artist-details.component.html',
  styleUrls: ['./artist-details.component.css']
})
export class ArtistDetailsComponent implements OnInit {
  artist: Artist | undefined;
  hoveredSong: Song = new Song();
  artistSongs: Song[] = [];
  artistPlaying: boolean = false;
  averageColor: any;

  constructor(
    private route: ActivatedRoute,
    private apiService: ApiService,
    private musicPlayerService: MusicPlayerService,
    private styleService: StyleService
  ){}

  ngOnInit(): void {
    this.route.paramMap.subscribe(params => {
      const artistId = parseInt(params.get('id')!);
      this.apiService.getArtistById(artistId).subscribe(artist => {
        this.artist = artist;

        this.apiService.getArtistSongs(artistId).subscribe(s => {
          this.artistSongs = s;
        });

        this.styleService.averageColor.subscribe(c => this.averageColor = c);
      });
    });
  }

  setSong(song: Song): void {
    this.musicPlayerService.addToQueue(song);
    this.musicPlayerService.setCurrentSong(song);
  }

  addToQueue(song: Song): void {
    this.musicPlayerService.addToQueue(song);
  }

  addAlbumToQueue(album: Album): void {
    if (album.songs) {
      this.musicPlayerService.addToQueueFromAlbum(album.songs);
    }
  }

  addArtistToQueue(artist: Artist){
    this.musicPlayerService.addToQueueFromAlbum(this.artistSongs);
    this.artistPlaying = !this.artistPlaying;
  }
}
