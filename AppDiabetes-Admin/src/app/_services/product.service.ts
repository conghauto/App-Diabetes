import { Injectable } from '@angular/core';
import { Product } from '../_models/Product';
import { environment } from 'src/environments/environment';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ToastrService } from 'ngx-toastr';
import { PaginatedResult } from '../_models/Pagination';
import { map } from 'rxjs/operators';
import { Food } from '../_models/Food';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  baseUrl = environment.apiUrl;
  food: Food;
  id: number;

  foods: Food[];
  constructor(private http: HttpClient, private toastrService: ToastrService) { }


  getFoods(): Observable<Food[]>{
    return this.http.get<Food[]>(`${this.baseUrl}admin/getFoods.php`).pipe(
      map((response) => {
        this.foods = response['data'];
        return this.foods;
      }, err => {
        this.toastrService.error(err);
      })
    );
  }

  getProduct(idProduct): Observable<Product>{
    this.id = idProduct;
    return this.http.get<Product>(this.baseUrl + 'products/' + idProduct);
  }

  addFood(food: Food){
    return this.http.post(`${this.baseUrl}admin/addFood.php`, { data: food });
  }


  deleteFood(id: number){
    const params = new HttpParams()
    .set('id', id.toString());
    return this.http.delete(this.baseUrl + 'admin/deleteFood.php', { params: params });
  }

  updateFood(updatedFood: Food){
    return this.http.post(`${this.baseUrl}admin/updateFood.php`, { data: updatedFood });
  }
}
