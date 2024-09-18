import { Component, Input } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterModule } from '@angular/router';

@Component({
  selector: 'app-breadcrumb-menu',
  standalone: true,
  imports: [CommonModule, RouterModule],
  templateUrl: './breadcrumb-menu.component.html',
  styleUrl: './breadcrumb-menu.component.scss'
})
export class BreadcrumbMenuComponent {

  @Input() menuItems: {
    name: string,
    link: string,
  }[] = [];

  @Input() currentPage: string = '';
  constructor() { }

}
