import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AppComponent } from '../app.component';

const httpOptions = {
  headers: new HttpHeaders({ 'Content-Type': 'application/json' })
}

@Injectable({
  providedIn: 'root'
})

export class AuthService {

  constructor(private http: HttpClient) { }

  login(email: string, password: string): Observable<any> {
    return this.http.post(AppComponent.PUBLIC_BACKEND_URL + '/users/signin',
    {
      email,  password
    },
    httpOptions);
  }

  registerUser(username: string, email: string, password: string): Observable<any> {
    return this.http.post(AppComponent.PUBLIC_BACKEND_URL + '/users/signup',
    {
      username,
      email,
      password,
      "roles": [{"id": "1", "name": "ROLE_USER"}]
    },
    httpOptions
    )
  }

  registerModerator(username: string, email: string, password: string): Observable<any> {
    return this.http.post(AppComponent.PUBLIC_BACKEND_URL + '/users/signup',
    {
      username,
      email,
      password,
      "role": "ROLE_MODERATOR"
    },
    httpOptions
    )
  }

  registerAdmin(username: string, email: string, password: string): Observable<any> {
    return this.http.post(AppComponent.PUBLIC_BACKEND_URL + '/users/signup',
    {
      username,
      email,
      password,
      "role": "ROLE_ADMIN"
    },
    httpOptions
    )
  }

  logout(): Observable<any> {
    window.sessionStorage.removeItem('auth-user')
    return this.http.post(AppComponent.PUBLIC_BACKEND_URL + '/users/signout', { }, httpOptions);
  }
}
