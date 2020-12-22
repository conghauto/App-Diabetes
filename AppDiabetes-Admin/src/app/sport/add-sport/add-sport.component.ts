import { Component, HostListener, OnInit, ViewChild } from '@angular/core';
import { NgForm } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { Sport } from 'src/app/_models/Sport';
import { SportService } from 'src/app/_services/sport.service';

@Component({
  selector: 'app-add-sport',
  templateUrl: './add-sport.component.html',
  styleUrls: ['./add-sport.component.scss']
})
export class AddSportComponent implements OnInit {
  constructor(public sportService: SportService, private route: ActivatedRoute, private router: Router,
    private toastrService: ToastrService) { }
  @ViewChild('form') form: NgForm;
  sport: Sport;
  @HostListener('window:beforeunload', ['$event'])
  unloadNotify($event: any){
  if  (this.form.dirty){
    $event.returnValue = true;
  }
}
  ngOnInit() {
    this.resetForm();
  }
  resetForm(form?: NgForm){
    if  (form != null) {
      form.resetForm();
    }

    this.sport = {
      id: null,
      name: '',
      technique: '',
      image: '',
      benefit: '',
      note: ''
    };
  }
  navigateToPage(){
    this.router.navigate(['admin/sports']);
  }

  addSport(){
    this.sportService.addSport(this.sport).subscribe( next => {
      this.toastrService.success('Thêm mới công thức thành công');
      this.navigateToPage();
    }, err => {
      console.log(err);
    this.toastrService.error(err);
    }
   );
  }


}
