/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { DetailedOrderService } from './detailedOrder.service';

describe('Service: DetailedOrder', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [DetailedOrderService]
    });
  });

  it('should ...', inject([DetailedOrderService], (service: DetailedOrderService) => {
    expect(service).toBeTruthy();
  }));
});
