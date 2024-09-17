import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BatchUploadsComponent } from './batch-uploads.component';

describe('BatchUploadsComponent', () => {
  let component: BatchUploadsComponent;
  let fixture: ComponentFixture<BatchUploadsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BatchUploadsComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BatchUploadsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
