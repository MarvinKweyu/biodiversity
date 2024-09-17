import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import ls from 'localstorage-slim';
import { environment } from '../../../../environments/environment';

@Injectable({
  providedIn: 'root'
})
export class DatasetService {

  constructor(private http: HttpClient) { }

  fetchUploads(searchTerm: string, cursor: string): any {
    return this.http.get(`${environment.baseUrl}images?search=${searchTerm}&cursor=${cursor}`);
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


}
