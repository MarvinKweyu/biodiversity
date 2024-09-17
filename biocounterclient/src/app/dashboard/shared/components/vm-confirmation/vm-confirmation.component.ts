import { Component, Inject } from '@angular/core';
import { MAT_DIALOG_DATA, MatDialogRef } from '@angular/material/dialog';
import { DatasetService } from '../../services/dataset.service';
import { CommonModule } from '@angular/common';
import { batchUpload } from '../../interfaces/batchUpload';


export interface vmContent {
  vmId: string;
  vmStatus: boolean;
}

@Component({
  selector: 'app-vm-confirmation',
  standalone: true,
  imports: [
    CommonModule
  ],
  templateUrl: './vm-confirmation.component.html',
  styleUrl: './vm-confirmation.component.scss'
})
export class VmConfirmationComponent {

  constructor(
    private dialogRef: MatDialogRef<VmConfirmationComponent>,
    @Inject(MAT_DIALOG_DATA) public vmStatus: vmContent,
    private vmService: DatasetService,

  ) {

  }

  updateVm() {
    const id = this.vmStatus.vmId;
    const data = { is_active: this.vmStatus.vmStatus } as batchUpload;
    this.vmService.updateVirtualMachine(id, data).subscribe({
      next: (res: any) => {
        this.dialogRef.close(res);
      },
      error: (error: any) => {
        console.log(error)
      }
    });
  }

  // todo: make this component reusable to confirm delee
  // accept the vmId, vmStatus and message as input
  // return the option selected by the user ok or cancel

}
