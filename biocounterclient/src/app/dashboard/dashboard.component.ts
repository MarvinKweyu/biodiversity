import { AfterViewInit, ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { Router, RouterModule } from '@angular/router';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner';
import { LoadingService } from './shared/services/loading.service';
import { SideNavComponent } from "./shared/components/side-nav/side-nav.component";
import { CommonModule } from '@angular/common';
import { AuthenticationService } from '../auth/services/authentication.service';

@Component({
  selector: 'app-dashboard',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatProgressSpinnerModule,
    SideNavComponent
  ],
  templateUrl: './dashboard.component.html',
  styleUrl: './dashboard.component.scss'
})
export class DashboardComponent implements OnInit, AfterViewInit {
  loading$: any;
  userIsStaff: boolean = false;
  admin_name: string = ''

  constructor(
    private router: Router,
    private changeDetectorRef: ChangeDetectorRef,
    private authService: AuthenticationService,
    private loadingService: LoadingService
  ) {

  }

  ngOnInit() {
    this.loading$ = this.loadingService.loading$;
    this.loading$.subscribe(() => {
      this.changeDetectorRef.detectChanges();
    });

    this.admin_name = this.authService.getCurrentUser().name || this.authService.getCurrentUser().email
  }

  ngAfterViewInit() {
    this.changeDetectorRef.detectChanges();
  }


}
