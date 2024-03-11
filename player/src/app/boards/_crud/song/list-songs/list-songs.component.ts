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
  selectedSong: Song = new Song();
  selectedSongAlbum: Album = new Album();
  selectedSongReset: any;
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
        if (s.album?.releaseDate) s.album.releaseDateString = s.album.releaseDate.toString().split('T')[0];
      });
    });
     
  }

  getSongsByAlbum(album: Album): Song[] {
    return this.songs.filter(song => song.album?.id === album.id);
  }

  showDetails(_t11: Song){
    this.selectedSong = _t11;
    if( _t11.album) this.selectedSongAlbum = _t11.album;
    this.selectedSongReset = _t11;
    console.log(JSON.stringify(this.selectedSong));
  }

  stringify(o: any) { return JSON.stringify(o) }

  compare(a: any, b: any){
    let expression = (a.id === b.id);
    console.log(a.id, '+', b.id, '=', expression);
    return expression;
  }

  saveSong(){
    if(this.editSong){ console.log("Saving song: " + JSON.stringify(this.selectedSong))}
    else this.editSong = !this.editSong;
  }

  cancelSong() { 
    console.log(JSON.stringify('RESET: ' + this.selectedSongReset));
    this.selectedSong = this.selectedSongReset;
    this.editSong = false;
  }

  saveAlbum(){
    if(this.editAlbum){ console.log("Saving album: " + JSON.stringify(this.selectedSong.album))}
    else this.editAlbum = !this.editAlbum;
  }

  cancelAlbum() { this.editAlbum = false }
}
