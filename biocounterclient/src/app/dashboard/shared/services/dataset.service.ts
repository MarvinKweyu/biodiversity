import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import ls from 'localstorage-slim';
import { environment } from '../../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class DatasetService {

  constructor(private http: HttpClient) { }

  fetchUploads(zipFileId: string, searchTerm: string, cursor: string): any {
    return this.http.get(`${environment.baseUrl}images?search=${searchTerm}&cursor=${cursor}&zip_file=${zipFileId}`);
  }

  fetchImage(id: string): any {
    return this.http.get(`${environment.baseUrl}images/${id}`);
  }

  processImages(): any {
    return this.http.post(`${environment.baseUrl}images/process/`, {});
  }

  setProcessing(satus: boolean) {
    ls.set('pr', status, { encrypt: true });
  }

  processingStatus(): any {
    return ls.get('pr', { decrypt: true });
  }

  fetchStats(): any {
    return this.http.get(`${environment.baseUrl}images/statistics/`);
  }

  uploadFile(formData: FormData): any {
    return this.http.post(`${environment.baseUrl}zipfiles/`, formData, {
      reportProgress: true,
      observe: 'events'
    });
  }
  fetchZipFiles(searchTerm: string, cursor: string): any {
    return this.http.get(`${environment.baseUrl}zipfiles?search=${searchTerm}&cursor=${cursor}`);
  }

  fetchZipFile(id: string): any {
    return this.http.get(`${environment.baseUrl}zipfiles/${id}`);
  }
  processZipFile(id: string): any {
    return this.http.get(`${environment.baseUrl}zipfiles/${id}/process/`);
  }



}
