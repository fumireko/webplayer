import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Album } from '../../../../shared/models/album.model';

@Component({
  selector: 'app-list-albums',
  templateUrl: './list-albums.component.html',
  styleUrl: './list-albums.component.css'
})
export class ListAlbumsComponent {

  selectedAlbum: any;
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
}
