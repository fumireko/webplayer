import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ListPlaylistsComponent } from './list-playlists.component';

describe('ListPlaylistsComponent', () => {
  let component: ListPlaylistsComponent;
  let fixture: ComponentFixture<ListPlaylistsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ListPlaylistsComponent]
    })
    .compileComponents();
    
    fixture = TestBed.createComponent(ListPlaylistsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
