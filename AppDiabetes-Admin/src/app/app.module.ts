import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import {HttpClientModule} from '@angular/common/http';
import {FormsModule} from '@angular/forms';
import { TabsModule } from 'ngx-bootstrap/tabs';
import { PaginationModule } from 'ngx-bootstrap/pagination';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {FileUploadModule} from 'ng2-file-upload';
import { JwtModule } from '@auth0/angular-jwt';

import { ToastrModule } from 'ngx-toastr';
import { AppComponent } from './app.component';
import { RouterModule } from '@angular/router';
import { appRoutes } from 'routes';
import { LoginComponent } from './login/login.component';
import { AuthService } from './_services/auth.service';
import { HomeComponent } from './home/home.component';
import { ErrorInterceptorProvider } from './_services/error.inteceptor';
import { ProductComponent } from './product/product.component';
import { ManufacturerComponent } from './manufacturer/manufacturer.component';
import { CustomerComponent } from './customer/customer.component';
import { TemplateComponent } from './template/template.component';
import { ManufacturerListResolver } from './_resolvers/manufacturer-list.resolver';
import { ManufacturerService } from './_services/manufacturer.service';
import { AddManufacturerComponent } from './manufacturer/add-manufacturer/add-manufacturer.component';
import { AlertifyService } from './_services/alertify.service';
import { UpdateManufacturerComponent } from './manufacturer/update-manufacturer/update-manufacturer.component';
import { ManufacturerEditResolver } from './_resolvers/manufacturer-edit.resolver';
import { ProductService } from './_services/product.service';
import { ProductEditResolver } from './_resolvers/product-edit.resolver';
import { PreventUnsavedChanges } from './_guards/prevent-unsaved-changes.guard';
import { AddProductComponent } from './product/add-product/add-product.component';
import { EditProductComponent } from './product/edit-product/edit-product.component';
import { UserService } from './_services/user.service';
import { OrdersService } from './_services/orders.service';import { UserListResolver } from './_resolvers/user-list.resolver';
import { ProductListResolver } from './_resolvers/product-list.resolver';
import { OrderListResolver } from './_resolvers/order-list.resolver';
import { CommonModule } from '@angular/common';
import { DetailProductComponent } from './product/detail-product/detail-product.component';
import { UpdateRecipeComponent } from './product/update-recipe/update-recipe.component';
import { AddRecipeComponent } from './product/add-recipe/add-recipe.component';
import { SportComponent } from './sport/sport.component';
import { UpdateSportComponent } from './sport/update-sport/update-sport.component';
import { DetailSportComponent } from './sport/detail-sport/detail-sport.component';
import { AddSportComponent } from './sport/add-sport/add-sport.component';
import { SportListResolver } from './_resolvers/sport-list.resolver';
export function tokenGetter(){
  return localStorage.getItem('token');
}

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HomeComponent,
    ProductComponent,
    ManufacturerComponent,
    CustomerComponent,
    TemplateComponent,
    AddManufacturerComponent,
    UpdateManufacturerComponent,
    EditProductComponent,
    AddProductComponent,
    DetailProductComponent,
    UpdateRecipeComponent,
    AddRecipeComponent,
    SportComponent,
    UpdateSportComponent,
    DetailSportComponent,
    AddSportComponent
   ],
  imports: [
    CommonModule,
    BrowserModule,
    HttpClientModule,
    FormsModule,
    FileUploadModule,
    TabsModule.forRoot(),
    PaginationModule.forRoot(),
    RouterModule.forRoot(appRoutes),
    BrowserAnimationsModule, // required animations module
    ToastrModule.forRoot(), // ToastrModule added
    JwtModule.forRoot({
      config: {
        tokenGetter,
        whitelistedDomains: ['localhost:5000'],
        blacklistedRoutes: ['localhost:5000/api/auth']
      }
    })
  ],
  providers: [
    AuthService,
    ErrorInterceptorProvider,
    ManufacturerListResolver,
    ManufacturerService,
    UserListResolver,
    ProductListResolver,
    AlertifyService,
    ManufacturerEditResolver,
    OrderListResolver,
    ProductService,
    ProductEditResolver,
    PreventUnsavedChanges,
    UserService,
    OrdersService,
    SportListResolver
  ],
  bootstrap: [AppComponent]
})
export class AppModule { }
