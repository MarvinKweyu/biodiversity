import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VmActivitiesComponent } from './vm-activities.component';

describe('VmActivitiesComponent', () => {
  let component: VmActivitiesComponent;
  let fixture: ComponentFixture<VmActivitiesComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [VmActivitiesComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VmActivitiesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
