import { CommonModule } from '@angular/common';
import { Component, Inject, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { batchUpload } from "../../shared/interfaces/batchUpload";
import { DatasetService } from "../../shared/services/dataset.service";
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';


@Component({
  selector: 'app-image-upload',
  standalone: true,
  imports: [
    CommonModule,

  ],
  templateUrl: './image-upload.component.html',
  styleUrl: './image-upload.component.scss'
})
export class ImageUploadComponent implements OnInit {



  constructor(
    private datasetService: DatasetService,
    private dialogRef: MatDialogRef<ImageUploadComponent>,
    @Inject(MAT_DIALOG_DATA) public image: batchUpload,
    private toastr: ToastrService,
  ) { }
  ngOnInit() {

  }

  close(): void {
    this.dialogRef.close();
  }


}
