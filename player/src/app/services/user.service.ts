import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { AppComponent } from '../app.component';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  constructor(private http: HttpClient) {}

  getPublicContent(): Observable<any> {
    return this.http.get(AppComponent.PUBLIC_BACKEND_URL + '/api/test/all', { responseType: 'text' });
  }

  getUserBoard(): Observable<any> {
    return this.http.get(AppComponent.PUBLIC_BACKEND_URL + '/api/test/user', { responseType: 'text' });
  }
  
  getModeratorBoard(): Observable<any> {
    return this.http.get(AppComponent.PUBLIC_BACKEND_URL + '/api/test/mod', { responseType: 'text' });
  }

  getAdminBoard(): Observable<any> {
    return this.http.get(AppComponent.PUBLIC_BACKEND_URL + '/api/test/admin', { responseType: 'text' });
  }
}
