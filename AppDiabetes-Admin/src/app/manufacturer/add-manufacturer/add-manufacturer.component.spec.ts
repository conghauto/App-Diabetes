import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { AddManufacturerComponent } from './add-manufacturer.component';

describe('AddManufacturerComponent', () => {
  let component: AddManufacturerComponent;
  let fixture: ComponentFixture<AddManufacturerComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ AddManufacturerComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AddManufacturerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
