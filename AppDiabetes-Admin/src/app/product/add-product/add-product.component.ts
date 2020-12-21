import { Component, OnInit, ViewChild, HostListener } from '@angular/core';
import { ProductService } from 'src/app/_services/product.service';
import { ActivatedRoute, Router } from '@angular/router';
import { ManufacturerService } from 'src/app/_services/manufacturer.service';
import { ToastrService } from 'ngx-toastr';
import { NgForm } from '@angular/forms';
import { Product } from 'src/app/_models/Product';
import { Manufacturer } from 'src/app/_models/Manufacturer';
import { Food } from 'src/app/_models/Food';

@Component({
  selector: 'app-add-product',
  templateUrl: './add-product.component.html',
  styleUrls: ['./add-product.component.css']
})
export class AddProductComponent implements OnInit {

  constructor(public productService: ProductService, private route: ActivatedRoute, private router: Router,
              private toastrService: ToastrService, private manufacturerService: ManufacturerService) { }
  @ViewChild('form') form: NgForm;
  food: Food;

  // arrMeal: Array<Object> = [
  //   {id: 1, nameVi: 'Bữa sáng', nameEng: 'breakfast'},
  //   {id: 2, nameVi: 'Bữa trưa', nameEng: 'lunch'},
  //   {id: 3, nameVi: 'Bữa tối', nameEng: 'dinner'},
  //   {id: 4, nameVi: 'Bữa phụ', nameEng: 'snack'}
  // ];

  arrMeal: Array<Object> = [
    {id: 1, nameVi: 'Bữa sáng'},
    {id: 2, nameVi: 'Bữa trưa'},
    {id: 3, nameVi: 'Bữa tối'},
    {id: 4, nameVi: 'Bữa phụ'}
  ];

  arrStateBG: Array<Object> = [
    {id: 1, nameVi: 'Đường huyết cao'},
    {id: 2, nameVi: 'Đường huyết thấp'},
  ];

 mealSelected: 1;
 stateBGSelected: 1;
  // tslint:disable-next-line: ban-types


  @HostListener('window:beforeunload', ['$event'])
    unloadNotify($event: any){
    if  (this.form.dirty){
      $event.returnValue = true;
    }
  }

  ngOnInit(): void {
    // this.manufacturerService.getManufacturers().subscribe(data => {
    //     this.manufacturers = data.result;
    //   }, err => {
    //     this.toastrService.error(err);
    // });

    this.mealSelected = 1;
    this.stateBGSelected = 1;
    this.resetForm();
  }

  resetForm(form?: NgForm){
    if  (form != null) {
      form.resetForm();
    }

    this.food = {
      id: 0,
      name: '',
      amount: 0,
      unit: '',
      calo: 0,
      protein: 0,
      lipid: 0,
      carb: 0,
      cellulose: 0,
      meal: 'breakfast',
      stateBG: 'high',
      image: ''
    };
  }


  addFood(){
    this.food.meal = this.mealSelected == 1? "breakfast" : this.mealSelected == 2? "lunch": this.mealSelected == 3? "dinner" : "snack";
    this.food.stateBG = this.stateBGSelected == 1? "high" : "low";
    console.log(this.food);
    this.productService.addFood(this.food).subscribe( next => {
      this.toastrService.success('Thêm món ăn thành công');
      this.navigateToPage();
    }, err => {
      console.log(err);
    this.toastrService.error(err);
  });

  }

  navigateToPage(){
    this.router.navigate(['admin/products']);
  }
}
