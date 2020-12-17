import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Manufacturer } from '../_models/Manufacturer';
import { PaginatedResult } from '../_models/Pagination';
import { map } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class ManufacturerService {
  baseUrl = environment.apiUrl;

  formData: Manufacturer;
  constructor(private http: HttpClient, private toastrService: ToastrService) { }

  getManufacturers(page?, itemsPerPage?, manufacturerParams?): Observable<PaginatedResult<Manufacturer[]>>{
    const paginatedResult: PaginatedResult<Manufacturer[]> = new PaginatedResult<Manufacturer[]>();
    let params = new HttpParams();

    if (page != null && itemsPerPage != null){
      params = params.append('pageNumber', page);
      params = params.append('pageSize', itemsPerPage);
    }

    if (manufacturerParams != null){
      params = params.append('name', manufacturerParams.name);
    }

    return this.http.get<Manufacturer[]>(this.baseUrl + 'manufacturers', {observe: 'response', params})
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

  getManufacturer(id): Observable<Manufacturer>{
    return this.http.get<Manufacturer>(this.baseUrl + 'manufacturers/' + id);
  }

  addManufacturer(){
    return this.http.post(this.baseUrl + 'manufacturers/add', this.formData);
  }

  updateManufacturer(id: number, manufacturer: Manufacturer){
    return this.http.put(this.baseUrl + 'manufacturers/' + id, manufacturer);
  }

  deleteManufacturer(id: number){
    return this.http.delete(this.baseUrl + 'manufacturers/' + id, {});
  }
}
