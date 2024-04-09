import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { LoginComponent } from './auth/login/login.component';
import { HomeComponent } from './home/home.component';
import { RegisterComponent } from './auth/register/register.component';
import { ProfileComponent } from './boards/_profile/profile.component';
import { UserComponent } from './boards/user/user.component';
import { ModeratorComponent } from './boards/moderator/moderator.component';
import { AdminComponent } from './boards/admin/admin.component';
import { ListArtistsComponent } from './boards/_crud/artist/list-artists/list-artists.component';
import { ListAlbumsComponent } from './boards/_crud/album/list-albums/list-albums.component';
import { ListGenresComponent } from './boards/_crud/genre/list-genres/list-genres.component';
import { ListPlaylistsComponent } from './boards/_crud/playlist/list-playlists/list-playlists.component';
import { ListSongsComponent } from './boards/_crud/song/list-songs/list-songs.component';
import { AlbumDetailsComponent } from './home/album-details/album-details.component';
import { ArtistDetailsComponent } from './home/artist-details/artist-details.component';

const routes: Routes = [
  { path: 'home', component: HomeComponent },
  { path: 'login', component: LoginComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'profile', component: ProfileComponent },
  { path: 'user', component: UserComponent },
  { path: 'mod', component: ModeratorComponent },
  { path: 'admin', component: AdminComponent },
  { path: 'admin/artists', component: ListArtistsComponent },
  { path: 'admin/artists/:id', component: ListArtistsComponent },
  { path: 'admin/albums', component: ListAlbumsComponent },
  { path: 'admin/albums/:id', component: ListAlbumsComponent },
  { path: 'admin/genres', component: ListGenresComponent },
  { path: 'admin/playlists', component: ListPlaylistsComponent },
  { path: 'admin/songs', component: ListSongsComponent },
  { path: 'admin/songs/:id', component: ListSongsComponent },
  { path: 'albums/:id', component: AlbumDetailsComponent},
  { path: 'artists/:id', component: ArtistDetailsComponent},
  { path: '', redirectTo: 'home', pathMatch: 'full' }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
