import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { RouterModule, Router } from '@angular/router';
import { ArrowRightComponent } from '../arrow-right/arrow-right.component';
import { AuthenticationService } from '../../../../auth/services/authentication.service';

@Component({
  selector: 'app-side-nav',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    ArrowRightComponent
  ],
  templateUrl: './side-nav.component.html',
  styleUrl: './side-nav.component.scss'
})
export class SideNavComponent implements OnInit{

  isCustomer: boolean = false;
  userIsGuest: boolean = false;
  userIsAdmin: boolean = false;
  admin_name: string = ''

  constructor(
    private router: Router,
    private authService: AuthenticationService,
  ) { }

  ngOnInit() {
    this.admin_name = this.authService.getCurrentUser().name
  }

  logout() {
    this.authService.logout();
    this.router.navigate(['/']);

  }

}
