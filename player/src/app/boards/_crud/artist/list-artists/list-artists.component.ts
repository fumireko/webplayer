import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Artist } from '../../../../shared/models/artist.model';

@Component({
  selector: 'app-list-artists',
  templateUrl: './list-artists.component.html',
  styleUrl: './list-artists.component.css'
})
export class ListArtistsComponent {

  selectedArtist: any;
  artists: Artist[] = [];

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getArtists().subscribe((data: Artist[]) => {
      this.artists = data;
    });
  }

  showDetails(_t11: Artist) {
    this.selectedArtist = _t11;
  }
}
