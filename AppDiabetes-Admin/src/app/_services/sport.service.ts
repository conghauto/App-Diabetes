import { HttpClient, HttpParams } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';
import { environment } from 'src/environments/environment';
import { Sport } from '../_models/Sport';

@Injectable({
  providedIn: 'root'
})
export class SportService {

  baseUrl = environment.apiUrl;
  sport: Sport;
  id: number;

  sports: Sport[];
  constructor(private http: HttpClient, private toastrService: ToastrService) { }


  getFoods(): Observable<Sport[]>{
    return this.http.get<Sport[]>(`${this.baseUrl}admin/getSport.php`).pipe(
      map((response) => {
        this.sports = response['data'];
        return this.sports;
      }, err => {
        this.toastrService.error(err);
      })
    );
  }

  getProduct(idProduct): Observable<Sport>{
    this.id = idProduct;
    return this.http.get<Sport>(this.baseUrl + 'products/' + idProduct);
  }

  addSport(food: Sport){
    return this.http.post(`${this.baseUrl}admin/addSport.php`, { data: food });
  }


  deleteSport(id: number){
    const params = new HttpParams()
    .set('id', id.toString());
    return this.http.delete(this.baseUrl + 'admin/deleteSport.php', { params: params });
  }

  updateSport(updatedSport: Sport){
    return this.http.post(`${this.baseUrl}admin/updateSport.php`, { data: updatedSport });
  }
}
