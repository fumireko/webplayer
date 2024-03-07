import { Component } from '@angular/core';
import { ApiService } from '../../../../services/api.service';
import { Playlist } from '../../../../shared/models/playlist.model';

@Component({
  selector: 'app-list-playlists',
  templateUrl: './list-playlists.component.html',
  styleUrl: './list-playlists.component.css'
})
export class ListPlaylistsComponent {

  selectedPlaylist: any;
  playlists: Playlist[] = [];

  constructor(private http: ApiService){}

  ngOnInit(){
    this.http.getPlaylists().subscribe((data: Playlist[]) => {
      this.playlists = data;
    });
  }

  showDetails(_t11: Playlist) {
    this.selectedPlaylist = _t11;
  }
}
