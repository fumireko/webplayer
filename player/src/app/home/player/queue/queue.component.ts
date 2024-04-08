// queue.component.ts
import { Component, EventEmitter, Input, Output, ViewChild } from '@angular/core';
import { Song } from '../../../shared/models/song.model';
import { NgbModal, NgbModalRef } from '@ng-bootstrap/ng-bootstrap';

@Component({
  selector: 'app-queue',
  templateUrl: './queue.component.html',
  styleUrls: ['./queue.component.css']
})
export class QueueComponent {
  @Input() queue: Song[] = [];
  @Output() removeSong = new EventEmitter<Song>();

  modalRef: NgbModalRef | undefined;
  @ViewChild('songQueueModal') modalContent: any;

  constructor(private modalService: NgbModal) {}

  removeFromQueue(song: Song): void {
    this.removeSong.emit(song);
  }

  openModal(): void {
    this.modalRef = this.modalService.open(this.modalContent, { centered: true });
  }

  closeModal(): void {
    if (this.modalRef) {
      this.modalRef.dismiss();
    }
  }
}
