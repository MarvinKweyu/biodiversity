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
import { UploadComponent } from './upload/upload.component';
import {ZipFile} from "../shared/interfaces/zip-file";


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
  batchUploads: ZipFile[] = [];
  statistics: any = { 'total_images': 0, 'total_flowers': 0, 'average_flowers': 0 };


  tableHeader: string[] = ["Name", "File count", "Status", "Updated", 'Uploaded',];
  processing: boolean = false;

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

    this.processing = this.datasetService.processingStatus();
    this.fetchStatistics();

  }

  fetchUploads(searchTerm: string, cursor: string) {
    this.datasetService.fetchZipFiles(searchTerm, cursor).subscribe({
      next: (res: any) => {
        this.batchUploads = res.results;
        this.paginationData = { previous: res.previous, next: res.next };
      },
      error: (error: any) => {
        this.toastr.error('Please try again later');
      }
    });
  }

  fetchStatistics(): void {
    this.datasetService.fetchStats().subscribe({
      next: (res: any) => {
        this.statistics = res;
      },
      error: (error: any) => {

        this.toastr.warning('We will load your statistics later');
      }
    });
  }

  uploadCompressedFile() {
    const dialogRef = this.dialog.open(UploadComponent, {
      width: 'auto',
      height: 'auto',
    });
    dialogRef.afterClosed().subscribe((res: any) => {
      this.fetchUploads('', '');

    });
  }

}
