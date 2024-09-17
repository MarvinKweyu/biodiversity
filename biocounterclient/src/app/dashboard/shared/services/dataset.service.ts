import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { batchUpload } from '../interfaces/batchUpload';

@Injectable({
  providedIn: 'root'
})
export class DatasetService {


  constructor(private http: HttpClient) { }

  getVirtualMachines(vmStatus: string, searchTerm: string, cursor: string): any {
    return this.http.get(`${environment.baseUrl}virtual-machines?search=${searchTerm}&cursor=${cursor}&is_active=${vmStatus}`);
  }

  fetchVirtualMachine(id: string): any {
    return this.http.get(`${environment.baseUrl}virtual-machines/${id}`);
  }

  updateVirtualMachine(id: string, data: batchUpload): any {
    return this.http.patch(`${environment.baseUrl}virtual-machines/${id}/`, data);
  }

  fetchOperatingSystems(): any {
    return this.http.get(`${environment.baseUrl}os-versions`);
  }

  fetchRegions(): any {
    return this.http.get(`${environment.baseUrl}regions`);
  }

  getStatistics() {
    return this.http.get(`${environment.baseUrl}virtual-machines/statistics`);
  }

  createVirtualMachine(data: batchUpload): any {
    return this.http.post(`${environment.baseUrl}virtual-machines/`, data);
  }

  createVmBackup(vmId: string): any {
    return this.http.post(`${environment.baseUrl}virtual-machines/${vmId}/backup/`, {});
  }

  deleteVirtualMachine(vmId: string): any {
    return this.http.delete(`${environment.baseUrl}virtual-machines/${vmId}/`);
  }

  assignCustomer(vmId: string, userId: number): any {
    return this.http.post(`${environment.baseUrl}virtual-machines/${vmId}/assign/`, { user_id: userId });
  }

  getCustomerVirtualMachines(userId: number, vmStatus: string, searchTerm: string, cursor: string) {
    return this.http.get(`${environment.baseUrl}virtual-machines?search=${searchTerm}&cursor=${cursor}&is_active=${vmStatus}&user__id=${userId}`);
  }

  fetchRatePlans(): any{
    return this.http.get(`${environment.baseUrl}rate-plans`)
  }

  fetchSubscriptions(userId: number, status: string,searchTerm: string, cursor: string): any {
    return this.http.get(`${environment.baseUrl}subscriptions?search=${searchTerm}&cursor=${cursor}&status=${status}&account__user__id=${userId}`)
  }

  fetchTransactionHistory(userId: number, searchTerm: string, cursor: string): any{
    return this.http.get(`${environment.baseUrl}transactions?search=${searchTerm}&cursor=${cursor}&account__user__id=${userId}`)
  }
}
