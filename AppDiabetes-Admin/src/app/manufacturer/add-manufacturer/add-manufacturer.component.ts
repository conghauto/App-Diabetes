import { Component, OnInit } from '@angular/core';
import { ManufacturerService } from 'src/app/_services/manufacturer.service';
import { NgForm } from '@angular/forms';
import { ToastrService } from 'ngx-toastr';
import { Router } from '@angular/router';

@Component({
  selector: 'app-add-manufacturer',
  templateUrl: './add-manufacturer.component.html',
  styleUrls: ['./add-manufacturer.component.css']
})
export class AddManufacturerComponent implements OnInit {

  constructor(public manufacturerService: ManufacturerService,
              private toastr: ToastrService, private router: Router) { }

  ngOnInit(): void {
    this.resetForm();
  }

  resetForm(form?: NgForm){
    if  (form != null) {
      form.resetForm();
    }

    this.manufacturerService.formData = {
      idManufacturer: 0,
      name: '',
      isActive: false,
    };
  }

  onSubmit(form: NgForm){
    this.manufacturerService.addManufacturer().subscribe(
      res => {
        this.resetForm(form);
        this.toastr.success('Thêm mới thành công');
      },
      err => {
        console.log(err);
      }
    );
  }

  navigateToPage(){
    this.router.navigate(['admin/manufacturers']);
  }
}
