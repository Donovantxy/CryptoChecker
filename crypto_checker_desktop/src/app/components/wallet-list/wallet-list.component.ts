import { Component, OnInit } from '@angular/core';
import { Store } from '@ngxs/store';
import { CryptoState } from '../../store/crypto.state';
import { Observable } from 'rxjs';
import { Token } from '../../store/token.model';
import { CommonModule } from '@angular/common';
import { TokenListItemComponent } from '../token-list-item/token-list-item.component';

@Component({
  selector: 'app-wallet-list',
  standalone: true,
  imports: [CommonModule, TokenListItemComponent],
  templateUrl: './wallet-list.component.html',
  styleUrl: './wallet-list.component.scss'
})
export class WalletListComponent implements OnInit {

  tokensSelector!: Observable<Token[]>;
  
  constructor(public readonly store: Store) {}

  ngOnInit() {
    this.tokensSelector = this.store.select(CryptoState.tokens);
  }
}
