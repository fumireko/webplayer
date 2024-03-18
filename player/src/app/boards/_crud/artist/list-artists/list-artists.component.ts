import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Artist } from '../../../../shared/models/artist.model';
import { Genre } from '../../../../shared/models/genre.model';

@Component({
  selector: 'app-list-artists',
  templateUrl: './list-artists.component.html',
  styleUrl: './list-artists.component.css'
})
export class ListArtistsComponent {

  selectedArtist: Artist = new Artist();
  selectedGenre: Genre = new Genre();
  newGenre: Genre = new Genre();
  addGenreToggle: boolean = false;

  artists: Artist[] = [];
  genres: Genre[] = [];

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getArtists().subscribe((data: Artist[]) => {
      this.artists = data;
    });
    this.http.getGenres().subscribe((data: Genre[]) => {
      this.genres = data;
    })
  }

  showDetails(_t11: Artist) {
    this.selectedArtist = _t11;
  }

  toggleAddGenre() {
    this.addGenreToggle = !this.addGenreToggle;
  }

  addGenre() {
    // Implement logic to add selected genre to the artist
  }

  resetEdit() {
    this.addGenreToggle = false;
  }
}
