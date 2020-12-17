import { Injectable } from '@angular/core';
import { environment } from 'src/environments/environment';
import { User } from '../_models/User';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';
import { PaginatedResult } from '../_models/Pagination';
import { map } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  baseUrl = environment.apiUrl;
  users: User[];

  constructor(private http: HttpClient, private toastrService: ToastrService) { }

  // getUsers(): Observable<User[]>{
  //   return this.http.get<User[]>(this.baseUrl + 'users');
  // }
  getUsers(): Observable<User[]>{
    return this.http.get<User[]>(`${this.baseUrl}admin/getUsers.php`).pipe(
      map((response) => {
        this.users = response['data'];
        return this.users;
      }, err => {
        this.toastrService.error(err);
      })
    );
  }

  deleteUser(id: number){
    const params = new HttpParams()
    .set('id', id.toString());
    return this.http.delete(this.baseUrl + 'admin/deleteUser.php', { params: params });
  }
}
