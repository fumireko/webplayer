import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../services/auth.service';
import { StorageService } from '../../services/storage.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  form: any = {
    email: null,
    password: null
  };

  isLoggedIn = false;
  isLoginFailed = false;
  errorMessage = '';
  roles: any[] = [];
  username = '';

  constructor(private authService: AuthService, private storageService: StorageService) { }

  ngOnInit(): void {
    this.checkLoggedIn();
  }

  onSubmit(): void {
    const { email, password } = this.form;

    this.authService.login(email, password).subscribe({
      next: data => {
        this.handleLoginSuccess(data);
      },
      error: err => {
        this.handleLoginFailure(err);
      }
    });
  }

  reloadPage(): void {
    window.location.reload();
  }

  private checkLoggedIn(): void {
    if (this.storageService.isLoggedIn()) {
      this.isLoggedIn = true;
      this.roles = this.storageService.getUser().roles;
      this.username = this.storageService.getUser().username;
    }
  }

  private handleLoginSuccess(data: any): void {
    this.storageService.saveUser(data);
    this.isLoginFailed = false;
    this.isLoggedIn = true;
    this.roles = this.storageService.getUser().roles;
    this.username = this.storageService.getUser().username;
    this.reloadPage();
  }

  private handleLoginFailure(err: any): void {
    this.errorMessage = err.error.message;
    this.isLoginFailed = true;
  }
}
