import { Component, OnInit } from '@angular/core';
import { AuthService } from '../_services/auth.service';
import { Router } from '@angular/router';
import { ToastrService } from 'ngx-toastr';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  model: any = {};
  constructor(private authService: AuthService, private router: Router,
              private toastrService: ToastrService) { }

  ngOnInit(): void {
  }

  login(){
    this.authService.login(this.model).subscribe(next => {
      this.toastrService.info('Đăng nhập thành công');
    }, error => {
      this.toastrService.error('Đăng nhập thất bại');
    }, () => {
      this.router.navigate(['admin/home']);
    });
  }
}
