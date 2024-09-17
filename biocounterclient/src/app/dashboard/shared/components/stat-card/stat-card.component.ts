import { Component, Input } from '@angular/core';

@Component({
  selector: 'app-stat-card',
  standalone: true,
  imports: [],
  templateUrl: './stat-card.component.html',
  styleUrl: './stat-card.component.scss'
})
export class StatCardComponent {
  @Input() background: any; // the background color of the card
  @Input() icon: any;
  @Input() title: any;
  @Input() value: any;
  @Input() showGraph: any = true;

}
