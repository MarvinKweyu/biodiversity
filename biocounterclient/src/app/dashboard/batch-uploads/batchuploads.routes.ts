import { Routes } from "@angular/router";

import { BatchUploadsComponent } from "./batch-uploads.component";
import { BatchUploadInfoComponent } from "./batch-upload-info/batch-upload-info.component";
import { ImageUploadComponent } from "./batch-upload-info/image-upload/image-upload.component";


export const batchuploadsRoutes: Routes = [
    {
        path: '',
        component: BatchUploadsComponent
    },
    {
        path: 'edit/:vmId',
        component: ImageUploadComponent,

    },
    {
        path: ':vmId',
        component: BatchUploadInfoComponent
    },


];
