import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Artist } from '../../../../shared/models/artist.model';
import { Genre } from '../../../../shared/models/genre.model';
import { ActivatedRoute } from '@angular/router';

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
  editGenreToggle: boolean = false;
  editIndex: number = -1;

  artists: Artist[] = [];
  genres: Genre[] = [];

  constructor(private http: ApiService,
              private route: ActivatedRoute){}

  ngOnInit(){
    this.http.getArtists().subscribe((data: Artist[]) => {
      this.artists = data;
      this.route.paramMap.subscribe(params => {
        const s = this.artists.find(a => a.id == parseInt(params.get('id')!))
        if (s) {
          this.selectedArtist = s;
          this.showDetails(s);
        }
      })  
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

  toggleEditGenre(index: number) {
    this.editIndex = index;
    this.editGenreToggle = !this.editGenreToggle;
  }

  addGenre() {
    this.selectedArtist.genres?.push(this.newGenre);
    this.saveArtist();
  }

  removeGenre(index: number){
    this.selectedArtist.genres?.splice(index, 1);
    this.saveArtist();
    this.resetEdit();
  }

  saveArtist(){
    this.resetEdit();
    this.http.updateArtist(this.selectedArtist).subscribe(artist => {
      this.selectedArtist = artist;
    })
  }

  filterGenres(): Genre[] {
    if (!this.selectedArtist || !this.selectedArtist.genres) {
      return this.genres;
    }
    return this.genres.filter(genre => !this.selectedArtist.genres!.some(g => g.id === genre.id));
  }

  resetEdit() {
    this.editIndex = -1;
    this.editGenreToggle = false;
    this.addGenreToggle = false;
    this.newGenre = new Genre();
  }
}
