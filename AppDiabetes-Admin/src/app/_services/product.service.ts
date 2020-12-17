import { Injectable } from '@angular/core';
import { Product } from '../_models/Product';
import { environment } from 'src/environments/environment';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ToastrService } from 'ngx-toastr';
import { PaginatedResult } from '../_models/Pagination';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  baseUrl = environment.apiUrl;
  product: Product;
  id: number;

  products: Product[];
  constructor(private http: HttpClient, private toastrService: ToastrService) { }

  getProducts(): Observable<Product[]>{
    return this.http.get<Product[]>(this.baseUrl + 'products/GetAll/');
  }

  getProductsForAdmin(page?, itemsPerPage?, productParams?): Observable<PaginatedResult<Product[]>>{
    const paginatedResult: PaginatedResult<Product[]> = new PaginatedResult<Product[]>();
    let params = new HttpParams();

    if (page != null && itemsPerPage != null){
      params = params.append('pageNumber', page);
      params = params.append('pageSize', itemsPerPage);
    }

    if (productParams != null){
      params = params.append('name', productParams.name);
    }

    return this.http.get<Product[]>(this.baseUrl + 'products/ForAdmin', {observe: 'response', params})
    .pipe(
      map(response => {
        paginatedResult.result = response.body;
        if (response.headers.get('Pagination') != null){
          paginatedResult.pagination = JSON.parse(response.headers.get('Pagination'));
        }
        return paginatedResult;
      }, err => {
        this.toastrService.error(err);
      })
    );
  }

  getProduct(idProduct): Observable<Product>{
    this.id = idProduct;
    return this.http.get<Product>(this.baseUrl + 'products/' + idProduct);
  }

  updateProduct(id: number, product: Product){
    this.id = id;
    return this.http.put(this.baseUrl + 'products/' + id, product);
  }

  setMain(idProduct: number, id: number){
    return this.http.post(this.baseUrl + 'products/' + idProduct
      + '/photos/' + id + '/setMain', {});
  }

  deletePhoto(idProduct: number, id: number){
    return this.http.delete(this.baseUrl + 'products/' + idProduct
      + '/photos/' + id);
  }

  addProduct(data: Product){
    return this.http.post(this.baseUrl + 'products/add', data);
  }

  deleteProduct(id: number){
    return this.http.delete(this.baseUrl + 'products/' + id, {});
  }
  getAllProducts(): Observable<Product[]>{
    return this.http.get<Product[]>(this.baseUrl + 'products/GetAll/');
  }
}
