import { CommonModule } from '@angular/common';
import { Component, Input } from '@angular/core';


export interface Activity {
  id: number;
  action: string;
  description: string;
  created: string;
  user: { id: number, name: string, role: string, email: string };

}
@Component({
  selector: 'app-vm-activities',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './vm-activities.component.html',
  styleUrl: './vm-activities.component.scss'
})
export class VmActivitiesComponent {
  @Input() activities: Activity[] = [] as Activity[];

}
