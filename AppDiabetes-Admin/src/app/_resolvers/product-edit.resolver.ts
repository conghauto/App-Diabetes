import { Injectable } from '@angular/core';
import { Resolve, Router, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { AlertifyService } from '../_services/alertify.service';
import { Product } from '../_models/Product';
import { ProductService } from '../_services/product.service';
import { ToastrService } from 'ngx-toastr';
import { Recipe } from '../_models/Recipe';
import { RecipeService } from '../_services/recipe.service';

@Injectable()
export class ProductEditResolver implements Resolve<Recipe[]>{
  constructor(private recipeSevice: RecipeService, private toastrService: ToastrService,
              private router: Router){}

  resolve(route: ActivatedRouteSnapshot): Observable<Recipe[]>{
    return this.recipeSevice.getRecipeByID(route.params['id']).pipe(
      catchError(error => {
        this.toastrService.error('Problem retrieving data');
        this.router.navigate(['admin/home']);
        return of(null);
      })
    );
  }
}
