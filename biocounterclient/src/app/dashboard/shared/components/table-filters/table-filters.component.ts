import { CommonModule } from '@angular/common';
import { Component, EventEmitter, Output } from '@angular/core';
import { ReactiveFormsModule, FormGroup, FormBuilder, Validators } from '@angular/forms';
import { RouterModule, Router, ActivatedRoute } from '@angular/router';

@Component({
  selector: 'app-table-filters',
  standalone: true,
  imports: [CommonModule, ReactiveFormsModule, RouterModule],
  templateUrl: './table-filters.component.html',
  styleUrl: './table-filters.component.scss'
})
export class TableFiltersComponent {
  searchForm: FormGroup;
  @Output() searchQuery: EventEmitter<string> = new EventEmitter<string>();

  constructor(
    private fb: FormBuilder,
    private router: Router,
    private activatedRoute: ActivatedRoute,
  ) {
    this.searchForm = this.fb.group({
      searchQuery: ['', [Validators.required, Validators.minLength(2)]],
    });
  }

  ngOnInit(): void {
    this.searchForm.get('searchQuery')?.valueChanges.subscribe(value => {
      if (value.length < 2) {
        // remove the search query from the url
        this.router.navigate([], {
          relativeTo: this.activatedRoute,
          queryParams: { search: null },
          queryParamsHandling: 'merge',
        });
        return;
      } else {

        // emit the value to the parent component
        // this.searchQuery.emit(value);
        this.performSearch(value);

      }

    });
  }

  get f() {
    return this.searchForm.controls;
  }

  submitSearch() {
    // send data to the parent component
    if (this.searchForm.invalid) {
      return;
    }
    this.performSearch(this.searchForm.value.searchQuery);
  }

  performSearch(searchTerm: string) {
    searchTerm = searchTerm.trim();
    // update current params with search query
    this.router.navigate([], {
      relativeTo: this.activatedRoute,
      queryParams: { search: searchTerm },
      queryParamsHandling: 'merge',
    });
  }

 

}
