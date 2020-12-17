import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { Manufacturer } from '../_models/Manufacturer';
import { ManufacturerService } from '../_services/manufacturer.service';
import { AlertifyService } from '../_services/alertify.service';
import { ToastrService } from 'ngx-toastr';
import { Pagination, PaginatedResult } from '../_models/Pagination';

@Component({
  selector: 'app-manufacturer',
  templateUrl: './manufacturer.component.html',
  styleUrls: ['./manufacturer.component.css']
})
export class ManufacturerComponent implements OnInit {
  manufacturers: Manufacturer[];
  manufacturerParams: any = {};
  pagination: Pagination;
  constructor(private router: Router, private manufacturerService: ManufacturerService, private route: ActivatedRoute,
              private alertifyService: AlertifyService, private toastrService: ToastrService) { }

  ngOnInit(): void {
    this.route.data.subscribe(data => {
      this.manufacturers = data.manufacturers.result;
      this.pagination = data.manufacturers.pagination;
    });

    this.manufacturerParams.name= '';
  }

  navigateToHome(){
    this.router.navigate(['admin/home']);
  }

  loadManufacturers(){
    this.manufacturerService
      .getManufacturers(this.pagination.currentPage, this.pagination.itemsPerPage, this.manufacturerParams)
      .subscribe((res: PaginatedResult<Manufacturer[]>) => {
        this.manufacturers = res.result;
        this.pagination = res.pagination;
        this.manufacturerParams.name = '';
    }, error => {
      this.toastrService.error(error);
    });
  }

  pageChanged(event: any){
    this.pagination.currentPage = event.page;
    this.loadManufacturers();
  }

  deleteManufacturer(id: number){
    this.alertifyService.confirm('Bạn có muốn xóa dòng vừa chọn', () => {
      this.manufacturerService.deleteManufacturer(id).subscribe(
        () => {
        this.manufacturers.splice(this.manufacturers.findIndex(m => m.idManufacturer === id), 1);
        this.toastrService.info('Xóa thành công');
        },
        err => {
          this.toastrService.error('Xóa thất bại');
        }
      );
    });
  }
}
