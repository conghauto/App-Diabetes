import { Component, OnInit } from '@angular/core';
import { Order } from '../_models/Order';
import { Router, ActivatedRoute } from '@angular/router';
import { OrdersService } from '../_services/orders.service';
import { AlertifyService } from '../_services/alertify.service';
import { Pagination, PaginatedResult } from '../_models/Pagination';

@Component({
  selector: 'app-order',
  templateUrl: './order.component.html',
  styleUrls: ['./order.component.css']
})
export class OrderComponent implements OnInit {
  listOrders: Order[];
  totalOrders: number;
  pagination: Pagination;
  orderParams: any = {};
  constructor(public router: Router, public orderService: OrdersService, public alert: AlertifyService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.route.data.subscribe(data => {
      this.listOrders = data.orders.result;
      this.pagination = data.orders.pagination;
    });

    this.orderParams.name = '';
  }
  navigateToHome(){
    this.router.navigate(['admin/home']);
  }
  //get all orders
  loadOrders(){
    this.orderService
      .getOrdersForAdmin(this.pagination.currentPage, this.pagination.itemsPerPage, this.orderParams)
      .subscribe((res: PaginatedResult<Order[]>) => {
        this.listOrders = res.result;
        this.pagination = res.pagination;
        this.orderParams.name = '';
    }, error => {
      this.alert.error(error);
    });
  }

  pageChanged(event: any){
    this.pagination.currentPage = event.page;
    this.loadOrders();
  }
  //update state of orders
  updateOrder(id: number, state: number){
      this.orderService.updateOrder(id, state).subscribe(next => {
        this.alert.success('Cập nhập thông tin thành công');
        this.loadOrders();
      }, error => {
        this.alert.error('Cập nhập thông tin thất bại');
      });
  }

}
