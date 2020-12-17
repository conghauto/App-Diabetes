import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { OrderDetail } from '../_models/OrderDetail';
import { environment } from 'src/environments/environment';

@Injectable({
  providedIn: 'root'
})
export class DetailedOrderService {
  baseUrl = environment.apiUrl;
constructor(private http: HttpClient) { }
GetListOrderDetail(id): Observable<OrderDetail[]>{
  return this.http.get<OrderDetail[]>(this.baseUrl + 'payment/order/detail/' + id);
}
}
