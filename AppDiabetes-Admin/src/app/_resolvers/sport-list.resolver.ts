import { Injectable } from '@angular/core';
import { Resolve, Router, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { ToastrService } from 'ngx-toastr';
import { Sport } from '../_models/Sport';
import { SportService } from '../_services/sport.service';

@Injectable()
export class SportListResolver implements Resolve<Sport[]>{
  pageNumber = 1;
  pageSize = 10;

  constructor(private sportService: SportService,
              private router: Router, private toastrService: ToastrService){}

  resolve(route: ActivatedRouteSnapshot): Observable<Sport[]>{
    return this.sportService.getFoods().pipe(
      catchError(error => {
        this.toastrService.error('Problem retrieving data');
        this.router.navigate(['admin/home']);
        return of(null);
      })
    );
  }
}
