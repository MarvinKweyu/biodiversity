import { Component, OnInit } from '@angular/core';
import { LoadingService } from '../../services/loading.service';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [],
  templateUrl: './home.component.html',
  styleUrl: './home.component.scss'
})
export class HomeComponent implements OnInit {

  constructor(private loadingService: LoadingService) {

  }

  ngOnInit(): void {
    // set loading to false since we are not loading anything in this component
    this.loadingService.hide();
  }

}
