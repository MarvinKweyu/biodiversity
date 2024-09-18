import { Routes } from "@angular/router";
import {ZipfileComponent} from "./zipfile/zipfile.component";
import { BatchUploadsComponent } from "./batch-uploads.component";



export const batchuploadsRoutes: Routes = [
  {
    path: "",
    component: BatchUploadsComponent
  },
  {
        path: ':zipId',
        component: ZipfileComponent
    },



];
