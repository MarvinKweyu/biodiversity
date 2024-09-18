import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, FormsModule, ReactiveFormsModule, Validators } from '@angular/forms';
import { DatasetService } from '../../shared/services/dataset.service';
import { MatProgressBarModule } from '@angular/material/progress-bar';
import { MatDialogRef } from '@angular/material/dialog';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-upload',
  standalone: true,
  imports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    MatProgressBarModule

  ],
  templateUrl: './upload.component.html',
  styleUrl: './upload.component.scss'
})
export class UploadComponent implements OnInit {
  fileForm: FormGroup;

  failedUpload: boolean = false;
  fileName: string = "";
  formData = new FormData();
  uploadProgress: any;
  acceptedFileTypes = ['application/zip', 'application/x-zip-compressed'];

  constructor(
    private fb: FormBuilder,
    private datasetService: DatasetService,
    private dialogRef: MatDialogRef<UploadComponent>,
    private toastr: ToastrService,
  ) {
    this.fileForm = this.fb.group({
      name: ['', [Validators.required]],
      zip_file: ['', [Validators.required]],
    });
  }

  ngOnInit(): void {
  }

  get f() {
    return this.fileForm.controls;
  }

  uploadFile(event: any): void {
    // @ts-ignore
    if (!event.target.files) {
      return
    }
    const file: File = event.target.files[0];
    this.fileName = file.name;


    // update the file form control
    this.fileForm.patchValue({
      zip_file: file
    })

    this.formData.append("zip_file", file);

  }

  sendToServer(): void {
    if (this.fileForm.invalid) {
      return;
    }
    this.formData.append("name", this.fileForm.value.name);

    this.datasetService.uploadFile(this.formData).subscribe({
      next: (res: any) => {
        this.uploadProgress = Math.round(100 * (res.loaded / res.total));

      },
      error: (error: any) => {
        this.toastr.error("There was a problem uploading your file");
      },
      complete: () => {
        this.dialogRef.close();
      }
    });

  }

}
