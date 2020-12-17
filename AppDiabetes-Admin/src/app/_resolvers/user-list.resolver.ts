import { Injectable } from '@angular/core';
import { Resolve, Router, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';
import { User } from '../_models/User';
import { UserService } from '../_services/user.service';

@Injectable()
export class UserListResolver implements Resolve<User[]>{
  pageNumber = 1;
  pageSize = 10;

  constructor(private userService: UserService,
              private router: Router, private toastrService: ToastrService){}

  resolve(route: ActivatedRouteSnapshot): Observable<User[]>{
    return this.userService.getUsers().pipe(
      catchError(error => {
        this.toastrService.error('Problem retrieving data');
        this.router.navigate(['admin/home']);
        return of(null);
      })
    );
  }
}
