import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { ToastrService } from 'ngx-toastr';
import { NavItem } from "../shared/interfaces/nav-item";
import { StatCardComponent } from "../shared/components/stat-card/stat-card.component";
import { TableFiltersComponent } from "../shared/components/table-filters/table-filters.component";
import { NavbarComponent } from "../shared/components/navbar/navbar.component";
import { PaginationComponent } from "../shared/components/pagination/pagination.component";
import { PlusIconComponent } from "../shared/components/plus-icon/plus-icon.component";
import { Pagination } from "../shared/interfaces/pagination";
import { batchUpload } from "../shared/interfaces/batchUpload";
import { DatasetService } from "../shared/services/dataset.service";
import { AuthenticationService } from "../../auth/services/authentication.service";
import { MatDialog } from '@angular/material/dialog';
import { ImageUploadComponent } from './image-upload/image-upload.component';


@Component({
  selector: 'app-batch-uploads',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    StatCardComponent,
    TableFiltersComponent,
    NavbarComponent,
    PaginationComponent,
    PlusIconComponent
  ],
  templateUrl: './batch-uploads.component.html',
  styleUrl: './batch-uploads.component.scss'
})
export class BatchUploadsComponent implements OnInit {

  navItems: NavItem[] = [
    {
      label: 'All',
      link: '/dashboard/batchuploads/',
      queryParams: {},

    },
    {
      label: 'Ready',
      link: '/dashboard/batchuploads/',
      queryParams: { ready: true },

    },
    {
      label: 'Processing',
      link: '/dashboard/batchuploads/',
      queryParams: { ready: false },

    }
  ]
  paginationData: Pagination = { previous: '', next: '' };
  batchUploads: batchUpload[] = [];
  statistics: any = { 'total': 0, 'Processed': 0, 'Processing': 0 };


  tableHeader: string[] = ["Meta", "Flower count", "Status", "Updated", 'Uploaded',];

  constructor(
    private datasetService: DatasetService,
    private router: Router,
    private toastr: ToastrService,
    private activatedRoute: ActivatedRoute,
    private authService: AuthenticationService,
    private dialog: MatDialog,
  ) { }

  ngOnInit(): void {
    this.activatedRoute.queryParams.subscribe((params) => {
      let searchTerm = params['search'] && params['search'].length > 2 ? params['search'].trim() : '';
      let cursor = params['cursor'] ? params['cursor'] : '';
      // batch_uploads
      this.fetchUploads(searchTerm, cursor);
    });


  }

  fetchUploads(searchTerm: string, cursor: string) {
    this.datasetService.fetchUploads(searchTerm, cursor).subscribe({
      next: (res: any) => {
        this.batchUploads = res.results;
        this.paginationData = { previous: res.previous, next: res.next };
      },
      error: (error: any) => {
        console.error(error);
        this.toastr.error('Please try again later');
      }
    });
  }

  showImage(imageUpload: batchUpload) {
    // open dialog
    const dialogRef = this.dialog.open(ImageUploadComponent, {
      width: '25vw',
      height: '40vh',
      data: imageUpload,
    });
    dialogRef.afterClosed().subscribe((res: any) => {


    });
  }

  processImages(): void {
    // this function will process the images
  }

}
