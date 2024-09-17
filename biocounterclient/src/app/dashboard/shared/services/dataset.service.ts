import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { batchUpload } from '../interfaces/batchUpload';

@Injectable({
  providedIn: 'root'
})
export class DatasetService {
  constructor(private http: HttpClient) { }

  fetchUploads(searchTerm: string, cursor: string): any {
    return this.http.get(`${environment.baseUrl}images`);
  }


  fetchImage(id: string): any {
    return this.http.get(`${environment.baseUrl}images/${id}`);
  }



}
