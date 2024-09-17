import { HttpErrorResponse, HttpInterceptorFn } from '@angular/common/http';
import { inject } from '@angular/core';
import { catchError, switchMap, throwError } from 'rxjs';
import { AuthenticationService } from '../services/authentication.service';

export const authInterceptor: HttpInterceptorFn = (req, next) => {
  const authService = inject(AuthenticationService);
  const token = authService.getToken();
  
  let clonedRequest = req;

  if (token) {
    clonedRequest = req.clone({
      setHeaders: {
        Authorization: `Bearer ${token}`,
      },
    });
  }

  return next(clonedRequest).pipe(
    catchError((error: HttpErrorResponse) => {
      if (error.status === 401 && !req.url.includes('token/refresh')) {
        // Token expired, attempt to refresh
        return authService.refreshToken().pipe(
          switchMap((newToken: string) => {
            if (newToken) {
              // Retry the original request with the new token
              clonedRequest = req.clone({
                setHeaders: {
                  Authorization: `Bearer ${newToken}`,
                },
              });
              return next(clonedRequest);
            } else {
              // Token refresh failed, log the user out
              authService.logout();
              return throwError(() => new Error('Token refresh failed'));
            }
          }),
          catchError(refreshError => {
            // Handle any errors from refreshing the token
            authService.logout();
            return throwError(() => refreshError);
          })
        );
      } else if (error.status === 403) {
        // Forbidden, log the user out
        authService.logout();
        return throwError(() => new Error('Unauthorized'));
      } else {
        
        return throwError(() => error);
      }
    })
  );
};


