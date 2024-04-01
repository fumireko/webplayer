// list-genres.component.ts
import { Component } from '@angular/core';
import { Genre } from '../../../../shared/models/genre.model';
import { ApiService } from '../../../../services/api.service';

@Component({
  selector: 'app-list-genres',
  templateUrl: './list-genres.component.html',
  styleUrls: ['./list-genres.component.css']
})
export class ListGenresComponent {

  selectedGenre: Genre | undefined;
  newGenre: Genre = new Genre();
  newGenreToggle: boolean = false;
  editGenre: boolean = false;
  genres: Genre[] = [];

  constructor(private http: ApiService) {}

  ngOnInit() {
    this.http.getGenres().subscribe((data: Genre[]) => {
      this.genres = data;
    });
  }

  showDetails(genre: Genre) {
    this.selectedGenre = genre;
  }

  toggleNewGenre() {
    this.newGenreToggle = !this.newGenreToggle;
  }

  toggleEditGenre() {
    this.editGenre = !this.editGenre;
  }

  saveNewGenre() {
    this.http.saveGenre(this.newGenre).subscribe((genre: Genre) => {
      this.genres.push(genre);
      this.resetEdit();
    });
  }

  saveGenre() {
    if (!this.selectedGenre) return;
    this.http.updateGenre(this.selectedGenre).subscribe((genre: Genre) => {
      if (this.selectedGenre) this.selectedGenre = genre;
      this.resetEdit();
    });
  }

  resetEdit() {
    this.editGenre = false;
    this.newGenreToggle = false;
    this.newGenre = new Genre();
  }
}
