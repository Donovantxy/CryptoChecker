import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, NavigationEnd, Router, RouterOutlet } from '@angular/router';
import { AppBarComponent } from './components/app-bar/app-bar.component';
import { Store } from '@ngxs/store';
import { LoadTokenQuotesAction } from './store/crypto.actions';
import { DrawerComponent } from './components/drawer/drawer.component';
import { CommonModule } from '@angular/common';
import { filter, interval, of } from 'rxjs';
import { CryptoState } from './store/crypto.state';
import { LocalStorageService } from './services/local-storage.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [CommonModule, RouterOutlet, AppBarComponent, DrawerComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent implements OnInit {

  isDrawerShown = false;
  viewTitle?: string;
  currentPath?: string;

  constructor(
    public readonly _activatedRoute: ActivatedRoute,
    public readonly _router: Router,
    private _store: Store,
    private _storageService: LocalStorageService
  ) {}

  ngOnInit(): void {
    this._router.events
    .pipe(filter(res => res instanceof NavigationEnd))
    .subscribe(() => {
      this.currentPath = this._activatedRoute.snapshot.firstChild?.routeConfig?.path;
      this.viewTitle = this._activatedRoute.snapshot.firstChild?.title;
    })
    this._store.select(CryptoState)
    .subscribe(state => {
      this._storageService.set('app-state', { crypto: state });
    });

    // start polling data
    interval(15000)
    .subscribe(() => this._store.dispatch(new LoadTokenQuotesAction()));
  }

  toggleDrawer() {
    this.isDrawerShown = !this.isDrawerShown;
  }

}
