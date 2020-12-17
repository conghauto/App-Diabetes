import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import {map} from 'rxjs/operators';
import {JwtHelperService} from '@auth0/angular-jwt';

@Injectable({
  providedIn: 'root'
})
export class AuthService {
  baseUrl = 'http://localhost:8080/api/admin';
  jwtHelper = new JwtHelperService();
  decodedToken: any;

  constructor(private http: HttpClient) { }

  login(model: any){
    console.log(model);
    return this.http.post(`${this.baseUrl}/login.php`, {data: model}).pipe(
      map((response:any) => {
        console.log('demo');
        if (response['token']){
          localStorage.setItem('token', response['token']);
          this.decodedToken = this.jwtHelper.decodeToken(response['token']);
          console.log(this.decodedToken);
        }
      })
    );
  }

  loggedIn(){
    const token = localStorage.getItem('token');
    return !this.jwtHelper.isTokenExpired(token);
  }

  logout(){
    localStorage.removeItem('token');
    console.log('Đăng xuất thành công!');
  }
}
