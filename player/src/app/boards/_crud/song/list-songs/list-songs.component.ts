import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Song } from '../../../../shared/models/song.model';
import { Album } from '../../../../shared/models/album.model';

@Component({
  selector: 'app-list-songs',
  templateUrl: './list-songs.component.html',
  styleUrl: './list-songs.component.css'
})
export class ListSongsComponent {

  editSong: boolean = false;
  editAlbum: boolean = false;
  selectedSong: any;
  songs: Song[] = [];
  albums: Album[] = [];

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getAlbums().subscribe((data: Album[]) => {
      this.albums = data;
    })
    this.http.getSongs().subscribe((data: Song[]) => {
      this.songs = data;
      this.songs.forEach(s => {
        if (s.album?.releaseDate) {
          s.album.releaseDateString = s.album.releaseDate.toString().split('T')[0];
        }
      });
    });
     
  }

  getSongsByAlbum(album: Album): Song[] {
    return this.songs.filter(song => song.album?.id === album.id);
  }

  showDetails(_t11: Song){
    this.selectedSong = _t11;
  }
}
