import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormControl, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { AuthenticationService } from './services/authentication.service';

@Component({
  selector: 'app-auth',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,

  ],
  templateUrl: './auth.component.html',
  styleUrl: './auth.component.scss'
})
export class AuthComponent implements OnInit {
  email = new FormControl('');
  loginForm: FormGroup;
  loginError: any;
  visiblePassword: boolean = false;
  width: number = 400;

  constructor(
    private fb: FormBuilder,
    private authService: AuthenticationService,

    private router: Router
  ) {
    this.loginForm = this.fb.group({
      email: ['', [Validators.required, Validators.email]],
      password: ['', Validators.required],
    });
  }

  ngOnInit(): void {

  }

  togglePassword() {
    this.visiblePassword = !this.visiblePassword;
  }
  get f() {
    return this.loginForm.controls;
  }

  login() {
    this.authService.login(this.loginForm.value).subscribe({
      next: (loginRes: any) => {
        this.authService.saveToken(
          loginRes.access
        );
        this.authService.saveRefreshToken(loginRes.refresh);
        this.authService.saveUser(
          loginRes.user
        );
        this.router.navigate(['/dashboard']);

      },
      error: (error: any) => {
        this.loginError = 'Invalid login credentials. Please try again.';
      }
    })
  }

}
