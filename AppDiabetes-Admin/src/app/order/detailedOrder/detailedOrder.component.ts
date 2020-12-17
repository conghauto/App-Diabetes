import { Component, OnInit } from '@angular/core';
import { DetailedOrderService } from 'src/app/_services/detailedOrder.service';
import { OrderDetail } from 'src/app/_models/OrderDetail';
import { Router, ActivatedRoute } from '@angular/router';
import { Product } from 'src/app/_models/Product';
import { ProductService } from 'src/app/_services/product.service';

@Component({
  selector: 'app-detailedOrder',
  templateUrl: './detailedOrder.component.html',
  styleUrls: ['./detailedOrder.component.css']
})
export class DetailedOrderComponent implements OnInit {

  listDetails: OrderDetail[];
  listProducts: Product[];
  id: any;
  totalPayment: number;
  totalUnit: number;
  productName: string;
  photoURL: string;
  constructor(private detailService: DetailedOrderService, private route: ActivatedRoute, private productService: ProductService  ) { }

  ngOnInit() {
    this.route.paramMap.subscribe(params => this.id = params.get('idOrder'));
    this.detailService.GetListOrderDetail(this.id).subscribe((data: OrderDetail[]) => {
      this.listDetails = data;
      this.totalUnit = this.listDetails.map(ps => ps.quantity)
      .reduce((prev, curr) => prev + curr, 0);
      this.totalPayment = this.listDetails.map(ps => ps.unitPrice * ps.quantity)
      .reduce((prev, curr) => prev + curr, 0);
    });

    this.productService.getAllProducts().subscribe(data =>
        {
          this.listProducts = data;
        });

  }
  isMatch(idProduct){
      let matchedProduct: Product;
      matchedProduct = this.listProducts.filter(p => p.idProduct == idProduct)[0];
      this.productName = matchedProduct.name;
      this.photoURL = matchedProduct.photoURL;
      return true;
  }

}
