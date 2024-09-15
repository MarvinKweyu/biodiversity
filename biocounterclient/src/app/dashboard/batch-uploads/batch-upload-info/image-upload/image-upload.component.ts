import { CommonModule } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import {BreadcrumbMenuComponent} from "../../../shared/components/breadcrumb-menu/breadcrumb-menu.component";
import {batchUpload} from "../../../shared/interfaces/batchUpload";
import {DatasetService} from "../../../shared/services/dataset.service";


@Component({
  selector: 'app-image-upload',
  standalone: true,
  imports: [
    CommonModule,
    BreadcrumbMenuComponent
  ],
  templateUrl: './image-upload.component.html',
  styleUrl: './image-upload.component.scss'
})
export class ImageUploadComponent implements OnInit {
  menuItems = [
    {
      name: 'Virtual Management',
      link: '/dashboard/virtualmachines'
    },
    {
      name: 'Loading...',
      link: '/dashboard/virtualmachines'
    }
  ];

  vmInfo: batchUpload = {} as batchUpload;
  constructor(
    private activatedRoute: ActivatedRoute,
    private datasetService: DatasetService,
    private toastr: ToastrService,
  ) { }
  ngOnInit() {
    this.activatedRoute.params.subscribe((params) => {

      this.fetchVirtualMachine(params['vmId']);
    });
  }

  fetchVirtualMachine(vmId: string) {
    this.datasetService.fetchVirtualMachine(vmId).subscribe({
      next: (vmInfo: any) => {
        this.vmInfo = vmInfo;
        // update the menu items link wby appending the id
        this.menuItems[1] = {
          name: vmInfo.name,
          link: `/dashboard/virtualmachines/${vmInfo._id}`
        };
      },
      error: (error: any) => {
        this.toastr.error('Something happened!', 'Unable to edit this vm at the moment');
      }

    });


  }



}
