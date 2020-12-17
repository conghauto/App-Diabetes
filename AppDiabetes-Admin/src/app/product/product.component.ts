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
    }, error => {
      this.toastrService.error(error);
    });
  }


  // deleteProduct(id: number){
  //   this.alertifyService.confirm('Bạn có muốn xóa Sản phẩm vừa chọn', () => {
  //     this.productService.deleteProduct(id).subscribe(
  //       () => {
  //       this.products.splice(this.products.findIndex(m => m.idProduct === id), 1);
  //       this.toastrService.info('Xóa thành công');
  //       },
  //       err => {
  //         this.toastrService.error('Xóa thất bại');
  //       }
  //     );
  //   });
  // }
}
