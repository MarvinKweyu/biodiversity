import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router, RouterModule } from '@angular/router';
import { CommonModule } from '@angular/common';
import { MatDialog } from '@angular/material/dialog';
import { MatMenuModule } from '@angular/material/menu';
import { MatButtonModule } from '@angular/material/button';
import { ToastrService } from 'ngx-toastr';
import {NavbarComponent} from "../../shared/components/navbar/navbar.component";
import {StatusPillComponent} from "../../shared/components/status-pill/status-pill.component";
import {BreadcrumbMenuComponent} from "../../shared/components/breadcrumb-menu/breadcrumb-menu.component";
import {DatasetService} from "../../shared/services/dataset.service";
import {ZipFile} from "../../shared/interfaces/zip-file";
import {PaginationComponent} from "../../shared/components/pagination/pagination.component";
import {TableFiltersComponent} from "../../shared/components/table-filters/table-filters.component";
import {Pagination} from "../../shared/interfaces/pagination";
import {batchUpload} from "../../shared/interfaces/batchUpload";
import {ImageUploadComponent} from "../image-upload/image-upload.component";

@Component({
  selector: 'app-zipfile',
  standalone: true,
  imports: [
    CommonModule,
    RouterModule,
    MatButtonModule,
    MatMenuModule,
    BreadcrumbMenuComponent,
    StatusPillComponent,
    NavbarComponent,
    PaginationComponent,
    TableFiltersComponent
  ],
  templateUrl: './zipfile.component.html',
  styleUrl: './zipfile.component.scss'
})
export class ZipfileComponent implements OnInit {
  menuItems = [
    {
      name: 'Zip files',
      link: '/dashboard/batchuploads'
    }
  ]
  link: string = '';


  zipFile: ZipFile = {} as ZipFile;
  zipId: string = '';
  batchUploads: batchUpload[] = [];
  tableHeader: string[] = ["Name", "Flower count", "Status", "Updated", 'Processed',];
  paginationData: Pagination = { previous: '', next: '' };

  constructor(
    private router: Router,
    private activatedRoute: ActivatedRoute,
    private datasetService: DatasetService,
    private dialog: MatDialog,
    private toastr: ToastrService,
  ) { }

  ngOnInit(): void {
    this.activatedRoute.params.subscribe((params: any) => {


      this.zipId = params['zipId'];
      this.fetchZipFile(params['zipId']);

    });
    this.activatedRoute.queryParams.subscribe((params) => {
      let searchTerm = params['search'] && params['search'].length > 2 ? params['search'].trim() : '';
      let cursor = params['cursor'] ? params['cursor'] : '';
      // batch_uploads

      this.fetchAssociatedImages(this.zipId, searchTerm, cursor);
    });

  }

  fetchZipFile(fileId: string) {
    this.datasetService.fetchZipFile(fileId).subscribe({
      next: (zipFile: any) => {
        this.zipFile = zipFile;
      },
      error: (error: any) => {
        this.toastr.error('Could not fetch this at this time. Try again later');
      }
    });
  }

  fetchAssociatedImages(zipFileId: string, searchTerm: string, cursor: string) {
    this.datasetService.fetchUploads(zipFileId, searchTerm, cursor).subscribe({
      next: (res: any) => {
        this.batchUploads = res.results;
        this.paginationData = { previous: res.previous, next: res.next };
      },
      error: (error: any) => {
        this.toastr.warning('Could not fetch the associated images at this time');
      }
    });

  }

  processFile(): void {
    this.datasetService.processZipFile(this.zipId).subscribe({
      next: (res: any) => {
        this.toastr.success('Images for this file are being processed');
        this.datasetService.setProcessing(true);

      },
      error: (error: any) => {
        if (error.status == 423) {
          this.toastr.warning('Images are already being processed. Please try again later');
        } else {
          this.toastr.warning('Please try again later');
        }
      }
    });
  }

  showImage(imageUpload: batchUpload): void {
    const dialogRef = this.dialog.open(ImageUploadComponent, {
      width: imageUpload.image_file ? '25vw' : '15vw',
      height: 'auto',
      data: imageUpload,
    });
    dialogRef.afterClosed().subscribe((res: any) => {

    });
  }


}
