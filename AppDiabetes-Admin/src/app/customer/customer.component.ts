import { Component, OnInit } from '@angular/core';
import { User } from '../_models/User';
import { UserService } from '../_services/user.service';
import { ToastrService } from 'ngx-toastr';
import { AlertifyService } from '../_services/alertify.service';
import { Pagination, PaginatedResult } from '../_models/Pagination';
import { ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-customer',
  templateUrl: './customer.component.html',
  styleUrls: ['./customer.component.css']
})
export class CustomerComponent implements OnInit {
  users: User[];
  userParams: any = {};
  pagination: Pagination;
  constructor(private userService: UserService, private toastrService: ToastrService,
              private alertifyService: AlertifyService, private route: ActivatedRoute) { }

  ngOnInit(): void {
    this.loadUsers();
    console.log(this.users);
    // this.route.data.subscribe(data => {
    //   this.users = data.customers.result;
    //   this.pagination = data.customers.pagination;
    // });

    // this.userParams.name = '';
  }

  // loadUsers(){
  //   this.userService.getUsers().subscribe((users: User[]) => {
  //     this.users = users;
  //   }, err => {
  //     this.toastrService.error(err);
  //   });
  // }

  loadUsers(){
    this.userService.getUsers()
      .subscribe((res: User[]) => {
        this.users = res;
    }, error => {
      this.toastrService.error(error);
    });
  }

  pageChanged(event: any){
    this.pagination.currentPage = event.page;
    this.loadUsers();
  }


  deleteUser(id: number){
    this.alertifyService.confirm('Bạn có muốn xóa dòng vừa chọn', () => {
      this.userService.deleteUser(id).subscribe(
        () => {
        this.users.splice(this.users.findIndex(m => m.id === id), 1);
        this.toastrService.info('Xóa thành công');
        },
        err => {
          this.toastrService.error('Xóa thất bại');
        }
      );
    });
  }
}
