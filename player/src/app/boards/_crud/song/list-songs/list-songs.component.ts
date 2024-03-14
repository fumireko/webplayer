import { Component, EventEmitter, Input, Output } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Song } from '../../../../shared/models/song.model';
import { Album } from '../../../../shared/models/album.model';

@Component({
  selector: 'app-list-songs',
  templateUrl: './list-songs.component.html',
  styleUrl: './list-songs.component.css'
})
export class ListSongsComponent {

  @Input() songData: Album | null = null;
  @Output() songDataChange: EventEmitter<Album | null> = new EventEmitter<Album | null>();

  editSong: boolean = false;
  editAlbum: boolean = false;
  selectedSong: Song = new Song();
  selectedSongAlbum: Album = new Album();
  selectedSongReset: string = "";

  songs: Song[] = [];
  albums: Album[] = [];
  resetSongs: string = "";
  resetAlbums: string = "";

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getAlbums().subscribe((data: Album[]) => {
      this.resetAlbums = JSON.stringify(data);
      this.albums = data;
    })
    this.http.getSongs().subscribe((data: Song[]) => {
      this.resetSongs = JSON.stringify(data);
      this.songs = data;
    });  
  }

  getSongsByAlbum(album: Album): Song[] {
    return this.songs.filter(song => song.album?.id === album.id);
  }

  getArtistsNames(album: Album | undefined): string {
    if(album) if(album.artists) return album.artists?.map(artist => artist.name).join(', ');
    return "";
  }

  showDetails(_t11: Song){
    this.selectedSong = _t11;
    this.selectedSongReset = JSON.stringify(_t11);
    if( _t11.album) this.selectedSongAlbum = _t11.album;
  }

  saveSong(){
    if(this.editSong){
      this.selectedSongAlbum = this.selectedSong.album!;
      this.editAlbum = !this.editAlbum;
      this.updateListing();
    }
    else this.editSong = !this.editSong;
  }

  cancelSong() {
    this.resetListing();
    this.editSong = false;
  }

  saveAlbum() {
    if (this.editAlbum) { 
      this.songs.filter(s => s.album?.id === this.selectedSong.album?.id).forEach(e => e.album = this.selectedSong.album);
      this.editAlbum = !this.editAlbum;
      this.updateListing();
    } 
    else this.editAlbum = !this.editAlbum;
  }

  cancelAlbum() {
    this.resetListing();
    this.editAlbum = false
  }

  updateListing(){
    this.http.getAlbums().subscribe((data: Album[]) => {
      this.resetAlbums = JSON.stringify(data);
      this.albums = data;
    })
    this.http.getSongs().subscribe((data: Song[]) => {
      this.resetSongs = JSON.stringify(data);
      this.songs = data;
    });
  }

  resetListing(){
    this.songs = JSON.parse(this.resetSongs);
    this.albums = JSON.parse(this.resetSongs);
    this.selectedSong = JSON.parse(this.selectedSongReset);
    this.selectedSongAlbum = this.selectedSong.album!;
  }
}
