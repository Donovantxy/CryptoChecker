import { CommonModule, CurrencyPipe } from '@angular/common';
import { Component, OnInit } from '@angular/core';
import { Store } from '@ngxs/store';
import { Observable, map, reduce, tap } from 'rxjs';
import { CryptoState } from '../../store/crypto.state';
import { Token } from '../../store/token.model';

@Component({
  selector: 'app-app-bar',
  standalone: true,
  imports: [CommonModule, CurrencyPipe],
  templateUrl: './app-bar.component.html',
  styleUrl: './app-bar.component.scss'
})
export class AppBarComponent implements OnInit {

  capitalSelector!: Observable<number>;

  constructor(public readonly store: Store) {}

  ngOnInit() {
    this.capitalSelector = this.store.select(CryptoState.tokens)
    .pipe(map((tokens: Token[]) => tokens.reduce((capital, token) => capital + token.bagSize*token.price, 0)));
  }

}
