import { Component, Input, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-status-pill',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './status-pill.component.html',
  styleUrl: './status-pill.component.scss'
})
export class StatusPillComponent implements OnInit {
  @Input() status: boolean = true;
  color: string = this.status ? 'bg-green-400' : 'bg-slate-400';

  @Input() message: string = ''

  ngOnInit(): void {

  }

}
