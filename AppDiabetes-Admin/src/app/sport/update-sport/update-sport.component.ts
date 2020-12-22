import { Component, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Sport } from 'src/app/_models/Sport';
import { SportService } from 'src/app/_services/sport.service';

@Component({
  selector: 'app-update-sport',
  templateUrl: './update-sport.component.html',
  styleUrls: ['./update-sport.component.scss']
})
export class UpdateSportComponent implements OnInit {

  constructor(private sportService: SportService, private route: ActivatedRoute, private router: Router,
              private toastrService: ToastrService) { }
  @ViewChild('form') form: NgForm;
  sport: Sport;
  sports: Sport[];
  idSport: any;


  ngOnInit(): void {
    this.route.paramMap.subscribe(params => this.idSport = params.get('id'));
    this.loadSports();
  }
  getUpdatedSport(){
    for(var i=0; i < this.sports.length; i++){
        if(this.sports[i].id == this.idSport){
          this.sport = this.sports[i];
        }
    }
  }
  loadSports(){
    this.sportService.getFoods()
      .subscribe((res: Sport[]) => {
        this.sports = res;
        this.getUpdatedSport();
    }, error => {
      this.toastrService.error(error);
    });
  }
  updateSport(){
    this.sportService.updateSport(this.sport).subscribe( next => {
      this.toastrService.success('Cập nhật thông tin thành công');
      this.navigateToPage();
    }, err => {
      this.toastrService.error(err);
    });

  }

  navigateToPage(){
    this.router.navigate(['admin/sports']);
  }

}
