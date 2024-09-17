import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BatchUploadInfoComponent } from './batch-upload-info.component';

describe('BatchUploadInfoComponent', () => {
  let component: BatchUploadInfoComponent;
  let fixture: ComponentFixture<BatchUploadInfoComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [BatchUploadInfoComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BatchUploadInfoComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
