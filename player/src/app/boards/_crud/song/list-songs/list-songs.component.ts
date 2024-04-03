import { Component, } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Song } from '../../../../shared/models/song.model';
import { Album } from '../../../../shared/models/album.model';
import { BehaviorSubject, Observable, combineLatest, map, of } from 'rxjs';
import { File } from '../../../../shared/models/file.model';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-list-songs',
  templateUrl: './list-songs.component.html',
  styleUrl: './list-songs.component.css'
})
export class ListSongsComponent {

  editSong: boolean = false;
  editAlbum: boolean = false;
  newSong: Song = new Song();
  selectedSong: Song = new Song();
  selectedSongAlbum: Album = new Album();
  selectedSongReset: string = "";
  newSongToggle: boolean = false;

  songs$: Observable<Song[]> | null = null;

  files: File[] = [];
  songs: Song[] = [];
  albums: Album[] = [];
  resetSongs: string = "";
  resetAlbums: string = "";

  sortedColumn$ = new BehaviorSubject<string>('');

  constructor(private http: ApiService,
              private route: ActivatedRoute){}

ngOnInit() {
  this.http.getFiles().subscribe((data: File[]) => {
    this.files = data;
  })
  this.http.getAlbums().subscribe((data: Album[]) => {
    this.resetAlbums = JSON.stringify(data);
    this.albums = data;
  });
  this.http.getSongs().subscribe((data: Song[]) => {
    this.resetSongs = JSON.stringify(data);
    this.songs = data;

    this.route.paramMap.subscribe(params => {
      const s = this.songs.find(s => s.id == parseInt(params.get('id')!))
      if (s) {
        this.selectedSong = s;
        this.showDetails(s);
      }
    })  
  
    this.songs$ = combineLatest(
      this.sortedColumn$,
      of(this.songs)
    ).pipe(
      map(([sortColumn, songs]) => sortColumn ? this.sortByColumn(songs, sortColumn) : songs)
    );

    this.songs$.subscribe(songs => {
      console.log(JSON.stringify(songs));
    });
  });
}


  getSongsByAlbum(album: Album): Song[] {
    return this.songs.filter(song => song.album?.id === album.id);
  }

  getArtistsNames(album: Album | undefined): string {
    console.log('Album:', album);
    if(album) console.log('Artists:', album.artists);
    
    if(album && album.artists)
      return album.artists.map(artist => artist.name).join(', ');
    else
      return "";
  }

  formatFileName(url: string){
    return url.substring(url.lastIndexOf('/') + 1).split('.').slice(0, -1).join('.');
  }

  showDetails(_t11: Song){
    this.selectedSong = _t11;
    this.selectedSongReset = JSON.stringify(_t11);
    if( _t11.album) this.selectedSongAlbum = _t11.album;
  }

  saveSong(){
    if(this.editSong){
      this.selectedSongAlbum = this.selectedSong.album!;
      this.http.updateSong(this.selectedSong).subscribe(s => {
        let songIndex = this.songs.findIndex(song => song.id === this.selectedSong.id);
        if (songIndex !== -1) {
          this.songs[songIndex] = s;
          this.selectedSong = s;
        }
      });
      this.http.updateAlbum(this.selectedSongAlbum).subscribe(a => {
        let albumIndex = this.albums.findIndex(album => album.id === this.selectedSongAlbum.id);
        if (albumIndex !== -1) {
          this.albums[albumIndex] = a;
          this.selectedSongAlbum = a;
        }
      });      
      this.editSong = !this.editSong;
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
      this.http.updateAlbum(this.selectedSongAlbum).subscribe(a => {
        let albumIndex = this.albums.findIndex(album => album.id === this.selectedSongAlbum.id);
        if (albumIndex !== -1) {
          this.albums[albumIndex] = a;
          this.selectedSong.album = a; // Update the album for the selected song
          this.songs.filter(s => s.album?.id === this.selectedSong.album?.id).forEach(e => e.album = a);
        }
      });      
      this.editAlbum = !this.editAlbum;
    } 
    else this.editAlbum = !this.editAlbum;
  }

  cancelAlbum() {
    this.resetListing();
    this.editAlbum = false
  }

  sortOn(column: string) {
    this.sortedColumn$.next(column);
  }

  sortByColumn(list: any[] | undefined, column: string, direction = 'desc'): any[] {
    let sortedArray = (list || []).sort((a, b) => {
      const propA = column.split('.').reduce((obj, key) => obj[key], a);
      const propB = column.split('.').reduce((obj, key) => obj[key], b);
  
      if (propA > propB) {
        return (direction === 'desc') ? 1 : -1;
      }
      if (propA < propB) {
        return (direction === 'desc') ? -1 : 1;
      }
      return 0;
    });
    return sortedArray;
  }  

  toggleNewSong(){
    this.newSongToggle = !this.newSongToggle;
  }

  saveNewSong(){
    this.http.saveSong(this.newSong).subscribe(e => {
      this.songs.push(e);
      JSON.parse(this.resetSongs).push(e);
      this.resetListing();
      this.newSongToggle = false;
      this.newSong = new Song();    
    });
  }

  resetListing(){
    this.songs = JSON.parse(this.resetSongs);
    this.albums = JSON.parse(this.resetAlbums);
    if(this.selectedSongReset) this.selectedSong = JSON.parse(this.selectedSongReset);
    this.selectedSongAlbum = this.selectedSong.album!;
    this.newSongToggle = false;
  }
}
