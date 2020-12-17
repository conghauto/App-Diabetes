import { Injectable } from '@angular/core';
import { CanDeactivate } from '@angular/router';
import { EditProductComponent } from '../product/edit-product/edit-product.component';

@Injectable()
export class PreventUnsavedChanges implements CanDeactivate<EditProductComponent>{
  canDeactivate(component: EditProductComponent){
    if (component.form.dirty){
      return confirm('Bạn có muốn tiếp tục hành động? Một số thay đổi sẽ không được lưu lại');
    }
    return true;
  }
}
