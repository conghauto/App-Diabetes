import { Injectable } from '@angular/core';
import { Resolve, Router, ActivatedRouteSnapshot } from '@angular/router';
import { Observable, of } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { ManufacturerService } from '../_services/manufacturer.service';
import { Manufacturer } from '../_models/Manufacturer';
import { AlertifyService } from '../_services/alertify.service';

@Injectable()
export class ManufacturerEditResolver implements Resolve<Manufacturer>{
  constructor(private manufacturerSevice: ManufacturerService,
              private router: Router, private alertify: AlertifyService){}

  resolve(route: ActivatedRouteSnapshot): Observable<Manufacturer>{
    return this.manufacturerSevice.getManufacturer(route.params['id']).pipe(
      catchError(error => {
        this.alertify.error('Problem retrieving data');
        this.router.navigate(['admin/home']);
        return of(null);
      })
    );
  }
}
