import { Injectable } from '@angular/core';
import { Resolve, Router, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AlertifyService } from '../_services/alertify.service';
import { Product } from '../_models/Product';
import { ProductService } from '../_services/product.service';
import { ToastrService } from 'ngx-toastr';

@Injectable()
export class ProductEditResolver implements Resolve<Product>{
  constructor(private productSevice: ProductService, private toastrService: ToastrService,
              private router: Router){}

  resolve(route: ActivatedRouteSnapshot): Observable<Product>{
    return this.productSevice.getProduct(route.params['id']).pipe(
      catchError(error => {
        this.toastrService.error('Problem retrieving data');
        this.router.navigate(['admin/home']);
        return of(null);
      })
    );
  }
}
