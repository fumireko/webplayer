import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { tap } from 'rxjs/operators';
import { AppComponent } from '../app.component';

const httpOptions = {
  headers: new HttpHeaders({ 'Content-Type': 'application/json' })
}

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  private token: string | null = null;

  constructor(private http: HttpClient) { }

  login(email: string, password: string): Observable<any> {
    return this.http.post<any>(`${AppComponent.PUBLIC_BACKEND_URL}/users/signin`,
    {
      email, password
    },
    httpOptions).pipe(
      tap(response => {
        this.token = response.token; // Salva o token após o login
        window.sessionStorage.setItem('auth-token', this.token!); // Armazena o token no sessionStorage
      })
    );
  }

  registerUser(username: string, email: string, password: string): Observable<any> {
    return this.http.post(`${AppComponent.PUBLIC_BACKEND_URL}/users/signup`,
    {
      username,
      email,
      password,
      "roles": [{"id": "1", "name": "ROLE_USER"}]
    },
    httpOptions
    );
  }

  registerModerator(username: string, email: string, password: string): Observable<any> {
    return this.http.post(`${AppComponent.PUBLIC_BACKEND_URL}/users/signup`,
    {
      username,
      email,
      password,
      "role": "ROLE_MODERATOR"
    },
    httpOptions
    );
  }

  registerAdmin(username: string, email: string, password: string): Observable<any> {
    return this.http.post(`${AppComponent.PUBLIC_BACKEND_URL}/users/signup`,
    {
      username,
      email,
      password,
      "role": "ROLE_ADMIN"
    },
    httpOptions
    );
  }

  logout(): Observable<any> {
    window.sessionStorage.clear();
    return this.http.post(`${AppComponent.PUBLIC_BACKEND_URL}/users/signout`, {}, httpOptions);
  }

  getToken(): string | null {
    if (!this.token) {
      this.token = window.sessionStorage.getItem('auth-token');
    }
    return this.token;
  }
}
