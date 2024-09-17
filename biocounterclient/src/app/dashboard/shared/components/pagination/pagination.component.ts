import { Component, EventEmitter, Input, OnInit, Output } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router, ActivatedRoute } from '@angular/router';
import { Pagination } from '../../interfaces/pagination';

@Component({
  selector: 'app-pagination',
  standalone: true,
  imports: [
    CommonModule
  ],
  templateUrl: './pagination.component.html',
  styleUrl: './pagination.component.scss'
})
export class PaginationComponent implements OnInit {
  @Input() paginationData: Pagination = { previous: '', next: '', }
  constructor(private router: Router, private activatedRoute: ActivatedRoute) { }

  ngOnInit() {
  }


  changePage(pageUrl: string) {
    // http://127.0.0.1:8000/api/users/?cursor=cD0yMDI0LTAxLTA5KzA0JTNBMjYlM0EzOC4wOTgzMzIlMkIwMCUzQTAw&search=test&status=
    //  take cD0yMDI0LTAxLTA5KzA0JTNBMjYlM0EzOC4wOTgzMzIlMkIwMCUzQTAw
    let cursor = pageUrl.split('?')[1].split('&')[0].split('=')[1];
    const routeWithoutParams = this.router.url.split('?')[0];
    // get current route
    this.router.navigate([routeWithoutParams], { queryParams: { ...this.activatedRoute.snapshot.queryParams, cursor: cursor } });

  }

}
