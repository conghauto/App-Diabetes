import {Routes} from '@angular/router';
import { LoginComponent } from 'src/app/login/login.component';
import { HomeComponent } from 'src/app/home/home.component';
import { ProductComponent } from 'src/app/product/product.component';
import { CustomerComponent } from 'src/app/customer/customer.component';
import { TemplateComponent } from 'src/app/template/template.component';
import { AuthGuard } from 'src/app/_guards/auth.guard';
import { ProductEditResolver } from 'src/app/_resolvers/product-edit.resolver';
import { PreventUnsavedChanges } from 'src/app/_guards/prevent-unsaved-changes.guard';
import { AddProductComponent } from 'src/app/product/add-product/add-product.component';
import { EditProductComponent } from 'src/app/product/edit-product/edit-product.component';
import { UserListResolver } from 'src/app/_resolvers/user-list.resolver';
import { ProductListResolver } from 'src/app/_resolvers/product-list.resolver';
import { OrderListResolver } from 'src/app/_resolvers/order-list.resolver';
import { DetailProductComponent } from 'src/app/product/detail-product/detail-product.component';
import { UpdateRecipeComponent } from 'src/app/product/update-recipe/update-recipe.component';
import { AddRecipeComponent } from 'src/app/product/add-recipe/add-recipe.component';
import { SportComponent } from 'src/app/sport/sport.component';
import { SportListResolver } from 'src/app/_resolvers/sport-list.resolver';
import { AddSportComponent } from 'src/app/sport/add-sport/add-sport.component';
import { UpdateSportComponent } from 'src/app/sport/update-sport/update-sport.component';
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
      { path: 'products/recipe/:id', component: DetailProductComponent,
          resolve: {product: ProductEditResolver}},
      { path: 'products/recipe/:id/add', component: AddRecipeComponent},
      { path: 'products/recipe/:id/update/:idRecipe', component: UpdateRecipeComponent},
      { path: 'products/edit/:idFood', component: EditProductComponent},
      { path: 'customers', component: CustomerComponent,
          resolve: {customers: UserListResolver}},
      { path: 'sports', component: SportComponent,
        resolve: {sports: SportListResolver}},
      { path: 'sports/add', component: AddSportComponent},
      { path: 'sports/edit/:id', component: UpdateSportComponent},
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
