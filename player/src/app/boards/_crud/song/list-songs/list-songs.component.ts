import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Song } from '../../../../shared/models/song.model';

@Component({
  selector: 'app-list-songs',
  templateUrl: './list-songs.component.html',
  styleUrl: './list-songs.component.css'
})
export class ListSongsComponent {

  selectedSong: any;
  songs: Song[] = [];

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getSongs().subscribe((data: Song[]) => {
      this.songs = data;
    }) 
  }

  showDetails(_t11: Song){
    this.selectedSong = _t11;
  }
}
