import { Injectable } from '@angular/core';
import { Resolve, Router, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';
import { Product } from '../_models/Product';
import { ProductService } from '../_services/product.service';

@Injectable()
export class ProductListResolver implements Resolve<Product[]>{
  pageNumber = 1;
  pageSize = 10;

  constructor(private productService: ProductService,
              private router: Router, private toastrService: ToastrService){}

  resolve(route: ActivatedRouteSnapshot): Observable<Product[]>{
    return this.productService.getFoods().pipe(
      catchError(error => {
        this.toastrService.error('Problem retrieving data');
        this.router.navigate(['admin/home']);
        return of(null);
      })
    );
  }
}
