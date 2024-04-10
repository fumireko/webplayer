import { Component } from '@angular/core';
import { StorageService } from './services/storage.service';
import { AuthService } from './services/auth.service';
import { AlbumDetailsComponent } from './home/album-details/album-details.component';
import { StyleService } from './services/style.service';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'player';
  static PUBLIC_BACKEND_URL: string = 'http://localhost:8080';
  private roles: any[] = [];
  isLoggedIn = false;
  showAdminBoard = false;
  showModeratorBoard = false;
  username?: string;
  averageColor: string = "rgb(10, 10, 10)";

  constructor(private storageService: StorageService, 
              private authService: AuthService,
              private styleService: StyleService) { }

  ngOnInit(): void {
    this.isLoggedIn = this.storageService.isLoggedIn();

    if (this.isLoggedIn) {
      const user = this.storageService.getUser();
      this.roles = user.roles;
      this.showAdminBoard = this.roles.some(role => role.name === 'ROLE_ADMIN');
      this.showModeratorBoard = this.roles.some(role => role.name === 'ROLE_MODERATOR');
      
      this.username = user.username;
    }
    
    this.styleService.averageColor.subscribe(c => this.averageColor = c);
  }

  logout(): void {
    this.authService.logout().subscribe({
      next: res => {
        console.log(res);
        this.storageService.clean();

        window.location.reload();
      },
      error: err => {
        console.log(err);
      }
    });
  }

  navigateBack() {
    window.history.back();
  }

  navigateForward() {
    window.history.forward();
  }
}
