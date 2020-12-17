import {Routes} from '@angular/router';
import { LoginComponent } from 'src/app/login/login.component';
import { HomeComponent } from 'src/app/home/home.component';
import { ProductComponent } from 'src/app/product/product.component';
import { ManufacturerComponent } from 'src/app/manufacturer/manufacturer.component';
import { OrderComponent } from 'src/app/order/order.component';
import { CustomerComponent } from 'src/app/customer/customer.component';
import { TemplateComponent } from 'src/app/template/template.component';
import { AuthGuard } from 'src/app/_guards/auth.guard';
import { AddManufacturerComponent } from 'src/app/manufacturer/add-manufacturer/add-manufacturer.component';
import { UpdateManufacturerComponent } from 'src/app/manufacturer/update-manufacturer/update-manufacturer.component';
import { ManufacturerEditResolver } from 'src/app/_resolvers/manufacturer-edit.resolver';
import {ManufacturerListResolver} from 'src/app/_resolvers/manufacturer-list.resolver';
import { ProductEditResolver } from 'src/app/_resolvers/product-edit.resolver';
import { PreventUnsavedChanges } from 'src/app/_guards/prevent-unsaved-changes.guard';
import { AddProductComponent } from 'src/app/product/add-product/add-product.component';
import { EditProductComponent } from 'src/app/product/edit-product/edit-product.component';
import { UserListResolver } from 'src/app/_resolvers/user-list.resolver';
import { ProductListResolver } from 'src/app/_resolvers/product-list.resolver';
import { DetailedOrderComponent } from 'src/app/order/detailedOrder/detailedOrder.component';
import { OrderListResolver } from 'src/app/_resolvers/order-list.resolver';
const childRoutes: Routes = [
  {
    path: '',
    runGuardsAndResolvers: 'always',
    canActivate: [AuthGuard],
    children: [
      { path: 'home', component: HomeComponent},
      { path: 'products', component: ProductComponent,
        resolve: {products: ProductListResolver}},
      { path: 'products/add', component: AddProductComponent},
      { path: 'products/:id', component: EditProductComponent,
          resolve: {product: ProductEditResolver}, canDeactivate: [PreventUnsavedChanges]},
      { path: 'orders', component: OrderComponent,
          resolve: {orders: OrderListResolver}},
      { path: 'orders/detail/:idOrder', component: DetailedOrderComponent},
      { path: 'customers', component: CustomerComponent,
          resolve: {customers: UserListResolver}},
      { path: 'manufacturers', component: ManufacturerComponent,
        resolve: {manufacturers: ManufacturerListResolver}},
      { path: 'manufacturers/add', component: AddManufacturerComponent},
      { path: 'manufacturers/:id', component: UpdateManufacturerComponent,
         resolve: {manufacturer: ManufacturerEditResolver}},
      { path: '', component: HomeComponent}
    ]
  },
  { path: '', component: HomeComponent, canActivate: [AuthGuard] }
];

export const appRoutes: Routes = [
  {path: 'admin', component: TemplateComponent, children: childRoutes},
  {path: 'admin/login', component: LoginComponent},
  { path: '',   redirectTo: '/admin/login', pathMatch: 'full'},
];
