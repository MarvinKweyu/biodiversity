import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VmConfirmationComponent } from './vm-confirmation.component';

describe('VmConfirmationComponent', () => {
  let component: VmConfirmationComponent;
  let fixture: ComponentFixture<VmConfirmationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VmConfirmationComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VmConfirmationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
