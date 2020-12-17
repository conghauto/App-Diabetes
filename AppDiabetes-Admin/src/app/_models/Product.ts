import { DecimalPipe } from '@angular/common';
import { Photo } from './Photo';

export class Product {
  idProduct: number;
  name: string;
  price: number;
  introduction: string;
  created?: Date;
  updated?: Date;
  quantity: number;
  isNew?: boolean;
  description?: string;
  idManufacturer: number;
  photoURL?: string;
  photos?: Photo[];
}
