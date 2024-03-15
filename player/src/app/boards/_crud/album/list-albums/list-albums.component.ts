import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Album } from '../../../../shared/models/album.model';

@Component({
  selector: 'app-list-albums',
  templateUrl: './list-albums.component.html',
  styleUrl: './list-albums.component.css'
})
export class ListAlbumsComponent {

  editAlbum: boolean = false;
  selectedAlbum: Album = new Album();

  albums: Album[] = [];

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getAlbums().subscribe((data: Album[]) => {
      this.albums = data;
    });
  }

  showDetails(_t11: Album) {
    this.selectedAlbum = _t11;
  }

  saveAlbum() {
    if (this.editAlbum) { 
      this.http.updateAlbum(this.selectedAlbum).subscribe(a => {
        let album = this.albums.find(a => a.id == this.selectedAlbum)
        album = a;
        this.selectedAlbum = a;
      });
      this.editAlbum = !this.editAlbum;
    } 
    else this.editAlbum = !this.editAlbum;
  }

  cancelAlbum() {
    this.editAlbum = false
  }
}
