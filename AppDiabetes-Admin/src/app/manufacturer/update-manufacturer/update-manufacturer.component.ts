import { Component, OnInit, ViewChild } from '@angular/core';
import { ToastrService } from 'ngx-toastr';
import { ManufacturerService } from 'src/app/_services/manufacturer.service';
import { Router, ActivatedRoute } from '@angular/router';
import { NgForm } from '@angular/forms';
import { Manufacturer } from 'src/app/_models/Manufacturer';

@Component({
  selector: 'app-update-manufacturer',
  templateUrl: './update-manufacturer.component.html',
  styleUrls: ['./update-manufacturer.component.css']
})
export class UpdateManufacturerComponent implements OnInit {

  constructor(private route: ActivatedRoute, private manufacturerService: ManufacturerService,
              private toastr: ToastrService, private router: Router) { }

  @ViewChild('editForm') editForm: NgForm;
  manufacturer: Manufacturer;
  ngOnInit() {
    this.route.data.subscribe(data => {
      this.manufacturer = data.manufacturer;
    });
  }

  resetForm(form?: NgForm){
    if  (form != null) {
      form.resetForm();
    }

    this.manufacturer = {
      idManufacturer: 0,
      name: '',
      isActive: false,
    };
  }

  onSubmit(){
    console.log(this.manufacturer);
    this.manufacturerService.updateManufacturer(this.manufacturer.idManufacturer, this.manufacturer).subscribe(next => {
      this.toastr.success('Cập nhập thông tin thành công');
      this.resetForm(this.editForm);
    }, error => {
      this.toastr.error('Cập nhập thông tin thất bại');
    });
  }

  navigateToPage(){
    this.router.navigate(['admin/manufacturers']);
  }
}
