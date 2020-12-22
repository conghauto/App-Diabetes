/* tslint:disable:no-unused-variable */

import { TestBed, async, inject } from '@angular/core/testing';
import { SportService } from './sport.service';

describe('Service: Sport', () => {
  beforeEach(() => {
    TestBed.configureTestingModule({
      providers: [SportService]
    });
  });

  it('should ...', inject([SportService], (service: SportService) => {
    expect(service).toBeTruthy();
  }));
});
