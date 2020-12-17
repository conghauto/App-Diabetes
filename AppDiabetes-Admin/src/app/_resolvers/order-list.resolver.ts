import { Injectable } from '@angular/core';
import { Resolve, Router, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';
import { ProductService } from '../_services/product.service';
import { Order } from '../_models/Order';
import { OrdersService } from '../_services/orders.service';

@Injectable()
export class OrderListResolver implements Resolve<Order[]>{
  pageNumber = 1;
  pageSize = 10;

  constructor(private orderService: OrdersService,
              private router: Router, private toastrService: ToastrService){}

  resolve(route: ActivatedRouteSnapshot): Observable<Order[]>{
    return this.orderService.getOrdersForAdmin(this.pageNumber, this.pageSize).pipe(
      catchError(error => {
        this.toastrService.error('Problem retrieving data');
        this.router.navigate(['admin/home']);
        return of(null);
      })
    );
  }
}
