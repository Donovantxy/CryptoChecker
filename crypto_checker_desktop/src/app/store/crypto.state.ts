import { Injectable } from '@angular/core';
import { Action, NgxsOnInit, Selector, State, StateContext, Store } from '@ngxs/store';
import { Token, tokenAsset } from './token.model';
import { LoadTokenQuotesAction, SetTokenBagSizeAction } from './crypto.actions';
import { Observable, map, of, tap } from 'rxjs';
import { CoinMarketCapService, MappedQuotesLatest } from '../services/coin-market-cap.service';
import { LocalStorageService } from '../services/local-storage.service';
import { patch, updateItem } from '@ngxs/store/operators';

export interface CryptoStateModel {
  tokens: Token[];
}

@State<CryptoStateModel>({
  name: 'crypto',
  defaults: {
    tokens: tokenAsset,
  },
})
@Injectable()
export class CryptoState implements NgxsOnInit {
  constructor(
    public readonly store: Store,
    private _coinMarketCapService: CoinMarketCapService,
    private _localStorageService: LocalStorageService
  ) {}

  ngxsOnInit({setState}: StateContext<CryptoStateModel>): void {
    const cryptoState = this._localStorageService.get<{ crypto: CryptoStateModel }>('app-state')?.crypto;
    if ( cryptoState ) {
      setState(cryptoState);
    }
  }

  @Selector()
  static tokens(state: CryptoStateModel): Token[] {
    return state.tokens.sort((a, b) =>
      a.symbol.toLocaleLowerCase() > b.symbol.toLocaleLowerCase() ? 1 : -1
    );
  }
  
  @Action(LoadTokenQuotesAction)
  loadTokenQuotesAction({
    patchState,
    getState,
  }: StateContext<CryptoStateModel>): Observable<Token[]> {
    return this._coinMarketCapService.getTokenQuotes(
      Object.values(getState().tokens).map((token) => token.id)
    )
    .pipe(
      map(res => {
        const tokens = getState().tokens;
        tokens.forEach(token => {
          token.price = res[token.id].usd;
          token.percentage = res[token.id].percDay;
        });
        patchState({ tokens });
        return tokens;
      })
    );
  }
  
  @Action(SetTokenBagSizeAction)
  setTokenBagSizeAction(
    { setState }: StateContext<CryptoStateModel>,
    { tokenId, bagSize }: SetTokenBagSizeAction
  ): void {
    console.log(bagSize);
    setState(
      patch<CryptoStateModel>({
        tokens: updateItem<Token>(
          token => token.id === tokenId,
          patch({bagSize})
        )
      })
    );
  }

}
