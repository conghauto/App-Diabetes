import { Component, OnInit, ViewChild, HostListener } from '@angular/core';
import { Product } from 'src/app/_models/Product';
import { ProductService } from 'src/app/_services/product.service';
import { ActivatedRoute, Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';
import { NgForm } from '@angular/forms';
import { Food } from 'src/app/_models/Food';

@Component({
  selector: 'app-edit-product',
  templateUrl: './edit-product.component.html',
  styleUrls: ['./edit-product.component.css']
})
export class EditProductComponent implements OnInit {
  constructor(private productService: ProductService, private route: ActivatedRoute, private router: Router,
              private toastrService: ToastrService) { }
  @ViewChild('form') form: NgForm;
  food: Food;
  foods: Food[];
  idFood: any;
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

  mealSelected: any;
  stateBGSelected: any;

  ngOnInit(): void {
    this.mealSelected = 1;
    this.stateBGSelected = 1;
    this.route.paramMap.subscribe(params => this.idFood = params.get('idFood'));
    this.loadFoods();
  }
  getUpdatedFood(){
    for(var i=0; i < this.foods.length; i++){
        if(this.foods[i].id == this.idFood){
          this.food = this.foods[i];
        }
    }
  }
  loadFoods(){
    this.productService.getFoods()
      .subscribe((res: Food[]) => {
        this.foods = res;
        this.getUpdatedFood();
        this.mealSelected = this.food.meal == "breakfast"? 1 : this.food.meal == "lunch" ? 2 : this.food.meal == "dinner" ? 3 : 4;
        this.stateBGSelected = this.food.stateBG == "high"? 1: 2;
    }, error => {
      this.toastrService.error(error);
    });
  }
  updateFood(){
    this.food.meal = this.mealSelected == 1? "breakfast" : this.mealSelected == 2? "lunch": this.mealSelected == 3? "dinner" : "snack";
    this.food.stateBG = this.stateBGSelected == 1? "high" : "low";
    this.productService.updateFood(this.food).subscribe( next => {
      this.toastrService.success('Cập nhật thông tin thành công');
      this.navigateToPage();
    }, err => {
      this.toastrService.error(err);
    });

  }

  navigateToPage(){
    this.router.navigate(['admin/products']);
  }
}
