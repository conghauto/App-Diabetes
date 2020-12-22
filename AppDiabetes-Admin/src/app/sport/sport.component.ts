import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Pagination } from '../_models/Pagination';
import { Sport } from '../_models/Sport';
import { AlertifyService } from '../_services/alertify.service';
import { SportService } from '../_services/sport.service';

@Component({
  selector: 'app-sport',
  templateUrl: './sport.component.html',
  styleUrls: ['./sport.component.scss']
})
export class SportComponent implements OnInit {
  sports: Sport[];
  listSportsClone: Sport[];
  sportParams: any = {};
  pagination: Pagination;
  constructor(private sportService: SportService, private toastrService: ToastrService,
              private router: Router, private alertifyService: AlertifyService, private route: ActivatedRoute ) { }

  ngOnInit(): void {
    this.loadSports();
  }


  navigateToHome(){
    this.router.navigate(['admin/home']);
  }

  loadSports(){
    this.sportService.getFoods()
      .subscribe((res: Sport[]) => {
        this.sports = res;
        this.listSportsClone = res;
    }, error => {
      this.toastrService.error(error);
    });
  }
  filterSports(){
    this.sports = this.listSportsClone;
    console.log(this.sportParams.name);
    this.sports = this.sports.filter((element) => element.name.includes(this.sportParams.name));
  }


  deleteFood(id: number){
    this.alertifyService.confirm('Bạn có muốn xóa dòng vừa chọn', () => {
      this.sportService.deleteSport(id).subscribe(
        () => {
        this.sports.splice(this.sports.findIndex(m => m.id === id), 1);
        this.toastrService.info('Xóa thành công');
        },
        err => {
          this.toastrService.error('Xóa thất bại');
        }
      );
    });
  }

}
