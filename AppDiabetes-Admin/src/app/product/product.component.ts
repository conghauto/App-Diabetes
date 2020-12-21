import { Component, OnInit } from '@angular/core';
import { Product } from '../_models/Product';
import { ProductService } from '../_services/product.service';
import { ToastrService } from 'ngx-toastr';
import { Router, ActivatedRoute } from '@angular/router';
import { AlertifyService } from '../_services/alertify.service';
import { Pagination, PaginatedResult } from '../_models/Pagination';
import { Food } from '../_models/Food';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit {
  foods: Food[];
  listFoodsClone: Food[];
  productParams: any = {};
  pagination: Pagination;
  constructor(private productService: ProductService, private toastrService: ToastrService,
              private router: Router, private alertifyService: AlertifyService, private route: ActivatedRoute ) { }

  ngOnInit(): void {
    this.loadFoods();
  }


  navigateToHome(){
    this.router.navigate(['admin/home']);
  }

  loadFoods(){
    this.productService.getFoods()
      .subscribe((res: Food[]) => {
        this.foods = res;
        this.listFoodsClone = res;
    }, error => {
      this.toastrService.error(error);
    });
  }
  filterFoods(){
    this.foods = this.listFoodsClone;
    console.log(this.productParams.name);
    this.foods = this.foods.filter((element) => element.name.includes(this.productParams.name));
  }


  deleteFood(id: number){
    this.alertifyService.confirm('Bạn có muốn xóa dòng vừa chọn', () => {
      this.productService.deleteFood(id).subscribe(
        () => {
        this.foods.splice(this.foods.findIndex(m => m.id === id), 1);
        this.toastrService.info('Xóa thành công');
        },
        err => {
          this.toastrService.error('Xóa thất bại');
        }
      );
    });
  }
}
