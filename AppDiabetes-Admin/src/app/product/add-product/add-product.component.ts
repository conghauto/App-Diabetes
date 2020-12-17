import { Component, OnInit, ViewChild, HostListener } from '@angular/core';
import { ProductService } from 'src/app/_services/product.service';
import { ActivatedRoute, Router } from '@angular/router';
import { ManufacturerService } from 'src/app/_services/manufacturer.service';
import { ToastrService } from 'ngx-toastr';
import { NgForm } from '@angular/forms';
import { Product } from 'src/app/_models/Product';
import { Manufacturer } from 'src/app/_models/Manufacturer';

@Component({
  selector: 'app-add-product',
  templateUrl: './add-product.component.html',
  styleUrls: ['./add-product.component.css']
})
export class AddProductComponent implements OnInit {

  constructor(public productService: ProductService, private route: ActivatedRoute, private router: Router,
              private toastrService: ToastrService, private manufacturerService: ManufacturerService) { }
  @ViewChild('form') form: NgForm;
  product: Product;

  proSelected: any;
  // tslint:disable-next-line: ban-types
  manufacturers: Manufacturer[];

  @HostListener('window:beforeunload', ['$event'])
    unloadNotify($event: any){
    if  (this.form.dirty){
      $event.returnValue = true;
    }
  }

  ngOnInit(): void {
    this.manufacturerService.getManufacturers().subscribe(data => {
        this.manufacturers = data.result;
      }, err => {
        this.toastrService.error(err);
    });

    this.proSelected = 1;
    this.resetForm();
  }

  resetForm(form?: NgForm){
    if  (form != null) {
      form.resetForm();
    }

    this.product = {
      idProduct: 0,
      name: '',
      price: 0,
      introduction: '',
      quantity: 0,
      isNew: false,
      description: '',
      idManufacturer: 1
    };
  }

  addProduct(){
    this.product.idManufacturer = this.proSelected;
    this.productService.addProduct(this.product).subscribe( next => {
      this.toastrService.success('Thêm sản phẩm tin thành công');
      this.form.reset();
    }, err => {
    this.toastrService.error(err);
  });

  }

  navigateToPage(){
    this.router.navigate(['admin/products']);
  }
}
