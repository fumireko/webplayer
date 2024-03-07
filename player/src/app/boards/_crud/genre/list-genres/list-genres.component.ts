import { Component } from '@angular/core';
import { Genre } from '../../../../shared/models/genre.model';
import { ApiService } from '../../../../services/api.service';

@Component({
  selector: 'app-list-genres',
  templateUrl: './list-genres.component.html',
  styleUrl: './list-genres.component.css'
})
export class ListGenresComponent {

  selectedArtist: any;
  genres: Genre[] = [];

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getGenres().subscribe((data: Genre[]) => {
      this.genres = data;
    });
  }

  showDetails(_t11: Genre) {
    this.selectedArtist = _t11;
  }
}
