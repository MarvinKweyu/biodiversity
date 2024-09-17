import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators, FormsModule, ReactiveFormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { CommonModule } from '@angular/common';
import { mergeMap } from 'rxjs';
import { AuthenticationService } from '../services/authentication.service';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    ReactiveFormsModule
  ],
  templateUrl: './register.component.html',
  styleUrl: './register.component.scss'
})
export class RegisterComponent implements OnInit {
  registrationForm: FormGroup;
  visiblePassword = false;
  width: number = 400;

  constructor(
    private fb: FormBuilder,
    public authService: AuthenticationService,

    private router: Router,
  ) {
    this.registrationForm = this.fb.group({
      name: ['', [Validators.pattern(this.authService.nameRegex)]],
      // ToDo: add async validator to check if email exists in database
      email: ['', [Validators.required, Validators.email]],
      password: ['', [Validators.required, Validators.minLength(6), Validators.maxLength(13),]],
    });

  }

  ngOnInit(): void {

  }

  get f() { return this.registrationForm.controls; }

  togglePassword() {
    this.visiblePassword = !this.visiblePassword;
  }
  register() {
    if (this.registrationForm.invalid) {
      return;
    }
    const registerData = this.registrationForm.value;
    // add a role to the registerData
    registerData.role = 'customer';
    registerData.password1 = registerData.password;
    registerData.password2 = registerData.password;


    this.authService.register(registerData).subscribe({
      next: (res: any) => {
        this.successfulRegistration(res);
      },
      error: (error: any) => {

        if (error.error.name) {
          this.registrationForm.get('name')?.setErrors({ invalid: true });
        }

      },
    });
  }

  successfulRegistration(res: any): void {
    this.authService.saveToken(
      res.access
    );
    this.authService.saveRefreshToken(res.refresh);
    // "http://127.0.0.1:8000/api/users/82/"
    const userId = res.user.url.split('/')[5];
    res.user.pk = res.user.pk ? res.user.pk : userId;
    this.authService.saveUser(
      res.user
    );

    this.router.navigate(['/dashboard']);
  }

}
