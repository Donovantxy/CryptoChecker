import { Component, OnInit } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { AppBarComponent } from './components/app-bar/app-bar.component';
import { Store } from '@ngxs/store';
import { LoadTokenQuotesAction } from './store/crypto.actions';
import { tap } from 'rxjs';
import { LocalStorageService } from './services/local-storage.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, AppBarComponent],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss',
})
export class AppComponent implements OnInit {
  constructor(
    private _store: Store,
    private _localStorageService: LocalStorageService
  ) {}

  ngOnInit(): void {
    // initialize the state with what we have stored in local-storage
    this._store.select((state) => state)
      .subscribe(state => {
        console.log(111, state);
        this._localStorageService.set('app-state', state);
      });
    // start polling data
    this._store.dispatch(new LoadTokenQuotesAction());
  }
}
