import { Component, Inject, OnInit } from '@angular/core';
import { NgSelectModule, NgSelectComponent } from '@ng-select/ng-select';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { CommonModule } from '@angular/common';
import {  Observable, of, Subject } from 'rxjs';
import {DatasetService} from "../../shared/services/dataset.service";

@Component({
  selector: 'app-assign-user',
  standalone: true,
  imports: [
    CommonModule,
    NgSelectModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  templateUrl: './assign-user.component.html',
  styleUrl: './assign-user.component.scss'
})
export class AssignUserComponent implements OnInit {

  assignForm: FormGroup;

  customer: any;
  customers$: Observable<any[]> = of([]);
  customersLoading = false;
  customersInput$ = new Subject<string>();
  selectedCustomer: any;


  constructor(
    private dialogRef: MatDialogRef<AssignUserComponent>,
    @Inject(MAT_DIALOG_DATA) private virtualmachine: any,
    private vmService: DatasetService,

    private fb: FormBuilder,
  ) {

    this.assignForm = this.fb.group({
      user: ['', [Validators.required]],
      vmId: [this.virtualmachine.vmId, [Validators.required]]
    });
  }

  ngOnInit(): void {
    this.fetchCustomers();
  }

  trackByFn(item: any) {
    return item._id;
  }

  fetchCustomers() {



  }

  assignCustomer() {
    const vmId = this.assignForm.value.vmId;
    const userId = this.assignForm.value.user;
    this.vmService.assignCustomer(vmId, userId).subscribe({
      next: (res: any) => {
        // create notification on server for both recipients
        this.dialogRef.close();
      },
      error: (error: any) => {
        console.log(error)
      }
    });
  }

  onSelectedCustomerChange(customer: any) {

    this.assignForm.patchValue({ user: customer.user_id });
  }
}
