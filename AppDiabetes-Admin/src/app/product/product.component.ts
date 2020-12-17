import { Component, OnInit } from '@angular/core';
import { Product } from '../_models/Product';
import { ProductService } from '../_services/product.service';
import { ToastrService } from 'ngx-toastr';
import { Router, ActivatedRoute } from '@angular/router';
import { AlertifyService } from '../_services/alertify.service';
import { Pagination, PaginatedResult } from '../_models/Pagination';

@Component({
  selector: 'app-product',
  templateUrl: './product.component.html',
  styleUrls: ['./product.component.css']
})
export class ProductComponent implements OnInit {
  products: Product[];
  productParams: any = {};
  pagination: Pagination;
  constructor(private productService: ProductService, private toastrService: ToastrService,
              private router: Router, private alertifyService: AlertifyService, private route: ActivatedRoute ) { }

  ngOnInit(): void {
    this.route.data.subscribe(data => {
      this.products = data.products.result;
      this.pagination = data.products.pagination;
    });

    this.productParams.name = '';
  }


  navigateToHome(){
    this.router.navigate(['admin/home']);
  }

  // loadProducts(){
  //   this.productService.getProducts().subscribe((products: Product[]) => {
  //     this.products = products;
  //   }, err => {
  //     this.toastrService.error(err);
  //   });
  // }

  loadProducts(){
    this.productService
      .getProductsForAdmin(this.pagination.currentPage, this.pagination.itemsPerPage, this.productParams)
      .subscribe((res: PaginatedResult<Product[]>) => {
        this.products = res.result;
        this.pagination = res.pagination;
    }, error => {
      this.toastrService.error(error);
    });
  }

  pageChanged(event: any){
    this.pagination.currentPage = event.page;
    this.loadProducts();
  }

  deleteProduct(id: number){
    this.alertifyService.confirm('Bạn có muốn xóa Sản phẩm vừa chọn', () => {
      this.productService.deleteProduct(id).subscribe(
        () => {
        this.products.splice(this.products.findIndex(m => m.idProduct === id), 1);
        this.toastrService.info('Xóa thành công');
        },
        err => {
          this.toastrService.error('Xóa thất bại');
        }
      );
    });
  }
}
