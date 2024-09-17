import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MatDialog } from '@angular/material/dialog';
import { MatMenuModule } from '@angular/material/menu';
import { MatButtonModule } from '@angular/material/button';
import { ToastrService } from 'ngx-toastr';

import { AssignUserComponent } from '../assign-user/assign-user.component';
import {BreadcrumbMenuComponent} from "../../shared/components/breadcrumb-menu/breadcrumb-menu.component";
import {StatusPillComponent} from "../../shared/components/status-pill/status-pill.component";
import {VmActivitiesComponent} from "../../shared/components/vm-activities/vm-activities.component";
import {NavbarComponent} from "../../shared/components/navbar/navbar.component";
import {NavItem} from "../../shared/interfaces/nav-item";
import {batchUpload} from "../../shared/interfaces/batchUpload";
import {DatasetService} from "../../shared/services/dataset.service";
import {AuthenticationService} from "../../../auth/services/authentication.service";
import {VmConfirmationComponent} from "../../shared/components/vm-confirmation/vm-confirmation.component";


@Component({
  selector: 'app-batch-upload-info',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatButtonModule,
    MatMenuModule,
    BreadcrumbMenuComponent,
    StatusPillComponent,
    VmActivitiesComponent,
    NavbarComponent
  ],
  templateUrl: './batch-upload-info.component.html',
  styleUrl: './batch-upload-info.component.scss'
})
export class BatchUploadInfoComponent implements OnInit {
  menuItems = [
    {
      name: 'Virtual Machines',
      link: '/dashboard/batchuploads'
    }
  ]

  filter: string = 'history';
  link: string = '';
  navItems: NavItem[] = [ {
      label: 'History',
      link: `/dashboard/batchuploads/12345`,
      queryParams: { filter: 'history' },

    },
    {
      label: 'VM Backups',
      link: `/dashboard/batchuploads/12345`,
      queryParams: { filter: 'backups' },

    },

  ];

  uploadData: batchUpload = {} as batchUpload;

  constructor(
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private datasetService: DatasetService,
    private dialog: MatDialog,
    private toastr: ToastrService,
    private authService: AuthenticationService,
  ) { }

  ngOnInit(): void {


    this.activatedRoute.params.subscribe((params: any) => {
      this.router.navigate([`/dashboard/batchuploads/${params['uploadId']}`], { queryParams: { filter: 'history' } });
      this.navItems[0].link = `/dashboard/batchuploads/${params['uploadId']}`;
      this.navItems[1].link = `/dashboard/batchuploads/${params['uploadId']}`;
      this.filter = params['filter'];
      this.fetchVirtualMachine(params['uploadId']);
    });

  }

  fetchVirtualMachine(uploadId: string) {
    this.datasetService.fetchVirtualMachine(uploadId).subscribe({
      next: (uploadData: any) => {
        this.uploadData = uploadData;
      },
      error: (error: any) => {
        this.toastr.error('Could not fetch this virtual machine at this time. Try again later');
      }
    });


  }

  toggleStatus(): void {
    // open dialog to confirm status change
    const dialogRef = this.dialog.open(VmConfirmationComponent, {
      width: '18vw',
      height: '15vh',
      data: { uploadId: this.uploadData._id, vmStatus: !this.uploadData.is_active },
    });
    dialogRef.afterClosed().subscribe((res: any) => {

      if (res) {
        this.fetchVirtualMachine(this.uploadData._id);
      }

    });
  }

  createBackup(): void {
    this.datasetService.createVmBackup(this.uploadData._id).subscribe({
      next: (res: any) => {
        this.uploadData.last_backup = res.backup;
        this.toastr.success('A backup process has been initiated');
      },
      error: (error: any) => {
        if (error.status == 402) {
          const message: string = error.error.message;
          this.toastr.warning(message);

        } else {
          this.toastr.error('Something happened!', 'We could not create your backup at this time. Please try again later');
        }
      }
    });
  }

  delete(): void {
    this.datasetService.deleteVirtualMachine(this.uploadData._id).subscribe({
      next: (res: any) => {
        this.toastr.success(`${this.uploadData.name} has been deleted`);
        this.router.navigate(['/dashboard/batchuploads']);
      },
      error: (error: any) => {
        this.toastr.error('Something happened!', 'Please try again later');
      }
    });

  }

  changeUser(): void {
    // open dialog to confirm status change
    const dialogRef = this.dialog.open(AssignUserComponent, {
      width: '32vw',
      height: '28vh',
      data: { uploadId: this.uploadData._id },
    });
    dialogRef.afterClosed().subscribe((res: any) => {
      if (res) {
        this.fetchVirtualMachine(this.uploadData._id);
      }

    });
  }
}
