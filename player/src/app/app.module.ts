import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './auth/login/login.component';
import { RegisterComponent } from './auth/register/register.component';
import { AdminComponent } from './boards/admin/admin.component';
import { ModeratorComponent } from './boards/moderator/moderator.component';
import { UserComponent } from './boards/user/user.component';
import { HomeComponent } from './home/home.component';
import { httpInterceptorProviders } from './services/http.service';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { CommonModule } from '@angular/common';
import { ProfileComponent } from './boards/_profile/profile.component';
import { ListArtistsComponent } from './boards/_crud/artist/list-artists/list-artists.component';
import { ListAlbumsComponent } from './boards/_crud/album/list-albums/list-albums.component';
import { ListGenresComponent } from './boards/_crud/genre/list-genres/list-genres.component';
import { ListPlaylistsComponent } from './boards/_crud/playlist/list-playlists/list-playlists.component';
import { ListSongsComponent } from './boards/_crud/song/list-songs/list-songs.component';
import { MinutesPipe } from './shared/pipes/minutes.pipe';
import { provideAnimationsAsync } from '@angular/platform-browser/animations/async';
import { PlayerComponent } from './home/player/player.component';
import { NavComponent } from './home/nav/nav.component';
import { QueueComponent } from './home/player/queue/queue.component';
import { NgbModule } from '@ng-bootstrap/ng-bootstrap';
import { AlbumDetailsComponent } from './home/album-details/album-details.component';
import { PlaylistDetailsComponent } from './home/playlist-details/playlist-details.component';
import { ArtistDetailsComponent } from './home/artist-details/artist-details.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    RegisterComponent,
    AdminComponent,
    ModeratorComponent,
    UserComponent,
    HomeComponent,
    ProfileComponent,
    ListArtistsComponent,
    ListAlbumsComponent,
    ListGenresComponent,
    ListPlaylistsComponent,
    ListSongsComponent,
    MinutesPipe,
    PlayerComponent,
    NavComponent,
    QueueComponent,
    AlbumDetailsComponent,
    PlaylistDetailsComponent,
    ArtistDetailsComponent
  ],
  imports: [
    CommonModule,
    BrowserModule,
    AppRoutingModule,
    FormsModule,
    HttpClientModule,
    NgbModule
  ],
  providers: [httpInterceptorProviders, provideAnimationsAsync()],
  bootstrap: [AppComponent]
})
export class AppModule { }
