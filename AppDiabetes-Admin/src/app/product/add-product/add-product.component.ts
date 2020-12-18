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

  arrMeal: Meal[] = [  
    {id: 1, nameEng: 'breakfast', nameVi: 'Bữa sáng'},  
    {id: 2, nameEng: 'lunch', nameVi: 'Bữa trưa'},    
    {id: 3, nameEng: 'dinner', nameVi: 'Bữa tối'},
    {id: 4, nameEng: 'snack', nameVi: 'Bữa phụ'}
 ];

 arrStateBG: StateBG[] = [  
  {id: 1, nameEng: 'high', nameVi: 'Đường huyết cao'},  
  {id: 2, nameEng: 'low', nameVi: 'Đường huyết thấp'},    
]; ;


 mealSelected: string;
 stateBGSelected: string;
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


    this.resetForm();
    
    this.stateBGSelected = 'high';
    this.mealSelected = 'breakfast';
   

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
    this.food.meal = this.mealSelected;
    this.food.stateBG = this.stateBGSelected;
    console.log(this.food);
    this.productService.addFood(this.food).subscribe( next => {
      this.toastrService.success('Thêm món ăn tin thành công');
      this.form.reset();
    }, err => {
    this.toastrService.error(err);
  });

  }

  navigateToPage(){
    this.router.navigate(['admin/products']);
  }
}

export interface Meal{  
  id:number;  
  nameEng: string;
  nameVi:string;
} 

export interface StateBG{  
  id:number;  
  nameEng: string;
  nameVi:string;
} 
