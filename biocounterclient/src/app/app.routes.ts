import { Routes } from '@angular/router';
import { AuthComponent } from './auth/auth.component';
import { alreadyLoggedInGuard } from './auth/guards/already-logged-in.guard';
import { authGuard } from './auth/guards/auth.guard';
import { RegisterComponent } from './auth/register/register.component';

export const routes: Routes = [
    {
        path: '',
        component: AuthComponent,
        canActivate: [alreadyLoggedInGuard]
    },
    {
        path: 'signup',
        component: RegisterComponent,
        canActivate: [alreadyLoggedInGuard]
    },
    {
        path: 'dashboard',
        loadChildren: () => import('./dashboard/dashboard.routes').then(m => m.dashboardRoutes),
        canActivate: [authGuard]
    },
    { path: '**', redirectTo: 'dashboard/home' }
];
