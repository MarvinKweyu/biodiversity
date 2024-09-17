import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable, catchError, of, switchMap, throwError } from 'rxjs';
import ls from 'localstorage-slim';
import { Login } from '../interfaces/login';
import { Register } from '../interfaces/register';
import { environment } from '../../../environments/environment';


@Injectable({
  providedIn: 'root',
})
export class AuthenticationService {

  constructor(
    private http: HttpClient,
  ) { }

  loginUrl = `${environment.baseUrl}account-auth/login/`
  registerUrl = `${environment.baseUrl}account-auth/registration/`
  nameRegex = /^[a-zA-Z ]{4,25}$/

  register(registerData: Register): any {
    return this.http.post(this.registerUrl, registerData);
  }

  login(loginData: Login): any {
    return this.http.post(this.loginUrl, loginData);
  }

  userInfo(): any {
    return this.http.get(`${environment.baseUrl}users/me/`);
  }

  saveToken(token: string) {
    ls.set('bt', token, { encrypt: true });
  }

  saveRefreshToken(token: string) {
    ls.set('br', token, { encrypt: true });
  }

  saveUser(user: Object) {
    ls.set('bu', user, { encrypt: true });
  }

  getToken(): any {
    return ls.get('bt', { decrypt: true });
  }

  getRefreshToken(): any {
    return ls.get('br', { decrypt: true });
  }

  getCurrentUser(): any {
    return ls.get('bu', { decrypt: true });
  }

  isLoggedIn(): boolean {
    const token: string | null = this.getToken();
    if (token) {
      try {
        // Decode the JWT and extract the payload
        const payload = JSON.parse(atob(token.split('.')[1]));


        if (payload && payload.exp) {
          const currentTime = Math.floor(Date.now() / 1000);
          return payload.exp > currentTime;
        }
      } catch (error) {
        console.error('Error decoding token:', error);
        return false;
      }
    }
    return false;

  }

  logout(): void {
    ls.clear();
  }

  refreshToken(): Observable<string> {
    const refreshToken = this.getRefreshToken();

    if (!refreshToken) {
      return throwError('No refresh token found.');
    }


    return this.http.post(`${environment.baseUrl}token/refresh`, { 'refresh': refreshToken }).pipe(
      catchError((error: any) => {
        return throwError('Token refresh failed.');
      }),
      switchMap((response: any) => {
        if (response && response.access_token && response.refresh_token) {
          this.saveToken(response.access_token);
          this.saveRefreshToken(response.refresh_token);
          return of(response.access_token);
        } else {
          return throwError('Token refresh failed.');
        }
      })
    );
  }


  getHeaders(): any {
    return {
      headers: new HttpHeaders({
        Authorization: `Bearer ${this.getToken()}`
      })
    };
  }


}
