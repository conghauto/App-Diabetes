import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Order } from '../_models/Order';
import { Observable } from 'rxjs';
import { PaginatedResult } from '../_models/Pagination';
import { AlertifyService } from './alertify.service';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class OrdersService {
baseUrl = 'http://localhost:5000/api/';
constructor(private http: HttpClient, private alertify: AlertifyService) { }
GetAllOrders(): Observable<Order[]>{
  return this.http.get<Order[]>(this.baseUrl);
}


getOrdersForAdmin(page?, itemsPerPage?, orderParams?): Observable<PaginatedResult<Order[]>>{
  const paginatedResult: PaginatedResult<Order[]> = new PaginatedResult<Order[]>();
  let params = new HttpParams();

  if (page != null && itemsPerPage != null){
    params = params.append('pageNumber', page);
    params = params.append('pageSize', itemsPerPage);
  }
  if (orderParams != null){
    params = params.append('name', orderParams.name);
  }
  return this.http.get<Order[]>(this.baseUrl + 'payment/ForAdmin', {observe: 'response', params})
  .pipe(
    map(response => {
      paginatedResult.result = response.body;
      if (response.headers.get('Pagination') != null){
        paginatedResult.pagination = JSON.parse(response.headers.get('Pagination'));
      }
      return paginatedResult;
    }, err => {
      this.alertify.error(err);
    })
  );
}
updateOrder(id: number, state: number){
  return this.http.put(this.baseUrl + 'payment/' + id + '/' + state, state);
}
}
