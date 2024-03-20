import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Album } from '../../../../shared/models/album.model';
import { Artist } from '../../../../shared/models/artist.model';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-list-albums',
  templateUrl: './list-albums.component.html',
  styleUrl: './list-albums.component.css'
})
export class ListAlbumsComponent {

  newAlbumToggle: boolean = false;
  addArtistToggle: boolean = false;
  editAlbum: boolean = false;
  editArtist: boolean = false;
  selectedAlbum: Album = new Album();
  editIndex: number = -1;
  newArtist: Artist = new Artist();
  newAlbum: Album = new Album();

  albums: Album[] = [];
  artists: Artist[] = [];

  constructor(private http: ApiService,
              private route: ActivatedRoute){}

  ngOnInit(){
    this.loadAlbums();
    this.loadArtists();
  }

  loadAlbums() {
    this.http.getAlbums().subscribe((data: Album[]) => {
      this.albums = data;
    });
  }

  loadArtists() {
    this.http.getArtists().subscribe((data: Artist[]) => {
      this.artists = data;
      this.route.paramMap.subscribe(params => {
        const s = this.albums.find(album => album.id == parseInt(params.get('id')!))
        if (s) {
          this.selectedAlbum = s;
          this.showDetails(s);
        }
      })  
    });
  }

  showDetails(album: Album) {
    console.log('showDetails');
    this.selectedAlbum = album;
  }

  toggleNewAlbum(){
    console.log('toggleNewAlbum');
    this.newAlbumToggle = !this.newAlbumToggle;
  }

  saveNewAlbum() {
    console.log('saveNewAlbum');
    console.log(JSON.stringify(this.newAlbum))
    this.http.saveAlbum(this.newAlbum).subscribe(e => {
      this.albums.push(e);
      this.resetEdit();
    });
  }

  toggleEditAlbum() {
    console.log('toggleEditAlbum');
    this.editAlbum = !this.editAlbum;
  }

  toggleAddArtist(){
    console.log('toggleAddArtist');
    this.addArtistToggle = !this.addArtistToggle;
  }

  toggleEditArtist(index: number) {
    console.log('toggleEditArtist');
    this.editIndex = index;
    this.editArtist = !this.editArtist;
  }

  addArtist(a: Album) {
    console.log('addArtist');
    a.artists?.push(this.newArtist);
    this.saveAlbum();
  }

  removeArtist(index: number) {
    console.log('removeArtist');
    this.selectedAlbum.artists?.splice(index, 1);
    this.saveAlbum();
    this.resetEdit();
  }

  saveAlbum() {
    console.log('saveAlbum');
    this.resetEdit();
    this.http.updateAlbum(this.selectedAlbum).subscribe(album => {
      this.selectedAlbum = album;
    });
  }

  resetEdit() {
    console.log('resetEdit');
    this.editIndex = -1;
    this.editAlbum = false;
    this.editArtist = false;
    this.addArtistToggle = false;
    this.newAlbumToggle = false;
    this.newArtist = new Artist();
  }

  filterArtists(): Artist[] {
    console.log('filterArtists');
    if (!this.selectedAlbum || !this.selectedAlbum.artists) {
      return this.artists;
    }
    return this.artists.filter(artist => !this.selectedAlbum.artists!.some(a => a.id === artist.id));
  }
}
