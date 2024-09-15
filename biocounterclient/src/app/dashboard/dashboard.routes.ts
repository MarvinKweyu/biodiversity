import { Routes } from "@angular/router";
import { HomeComponent } from "./shared/components/home/home.component";
import { DashboardComponent } from "./dashboard.component";

export const dashboardRoutes: Routes = [
  {
    path: '',
    component: DashboardComponent,
    children: [
      { path: '', redirectTo: 'home', pathMatch: 'full' },
      {
        path: 'home',
        component: HomeComponent
      },
      {
        path: 'batchuploads',
        loadChildren: () => import('./batch-uploads/batchuploads.routes').then(m => m.batchuploadsRoutes)
      }

    ]
  }
]
