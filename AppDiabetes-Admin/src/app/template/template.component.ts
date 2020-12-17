import { Component, OnInit } from '@angular/core';
import { AuthService } from '../_services/auth.service';
import { ToastrService } from 'ngx-toastr';
import { Router } from '@angular/router';

@Component({
  selector: 'app-template',
  templateUrl: './template.component.html',
  styleUrls: ['./template.component.css']
})
export class TemplateComponent implements OnInit {

  constructor(public authSerice: AuthService, private toastrService: ToastrService,
              private router: Router ) { }

  ngOnInit(): void {
  }

  logOut(){
    localStorage.removeItem('token');
    // this.alertify.message('Thoát');
    this.toastrService.success('Đăng xuất thành công');
    this.router.navigate(['admin/login']);
  }
}
