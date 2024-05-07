import { Injectable } from '@angular/core';
import { Action, NgxsOnInit, Selector, State, StateContext, Store } from '@ngxs/store';
import { Token, tokenAsset } from './token.model';
import { LoadTokenQuotesAction, SetSortByAction, SetSortingAction, SetTokenBagSizeAction, ToggleTokenVisibilityAction } from './crypto.actions';
import { Observable, map, of, tap } from 'rxjs';
import { CoinMarketCapService, MappedQuotesLatest } from '../services/coin-market-cap.service';
import { LocalStorageService } from '../services/local-storage.service';
import { patch, updateItem } from '@ngxs/store/operators';

export interface CryptoStateModel {
  tokens: Token[];
  sortBy: SortBy;
  sorting: Sorting;
}

export enum SortBy {
  PRICE = 'price',
  BAG = 'bag',
  NAME = 'name',
  PERC = 'perc',
}

export enum Sorting {
  ASC = 1,
  DESC = -1
} 

@State<CryptoStateModel>({
  name: 'crypto',
  defaults: {
    tokens: tokenAsset,
    sortBy: SortBy.NAME,
    sorting: Sorting.ASC
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
    const currSortBy = state.sortBy;
    const sorting = state.sorting === Sorting.ASC ? [1, -1] : [-1, 1];
    
    switch ( currSortBy ) {
      case SortBy.BAG: 
        return state.tokens.sort((a, b) => a.bagSize > b.bagSize ? sorting[0] : sorting[1]);
      case SortBy.PRICE: 
        return state.tokens.sort((a, b) => a.price > b.price ? sorting[0] : sorting[1]);
      case SortBy.PERC: 
        return state.tokens.sort((a, b) => a.percentage > b.percentage ? sorting[0] : sorting[1]);
      default:
        return state.tokens.sort((a, b) => a.symbol.toLocaleLowerCase() > b.symbol.toLocaleLowerCase() ? sorting[0] : sorting[1]);
    }
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
    setState(
      patch<CryptoStateModel>({
        tokens: updateItem<Token>(token => token.id === tokenId, patch({bagSize}))
      })
    );
  }
  
  @Action(SetSortByAction)
  setSortByAction(
    { setState }: StateContext<CryptoStateModel>,
    { sortBy }: SetSortByAction
  ): void {
    setState(patch<CryptoStateModel>({sortBy}));
  }
  
  @Action(SetSortingAction)
  setSortingAction(
    { setState }: StateContext<CryptoStateModel>,
    { sorting }: SetSortingAction
  ): void {
    setState(patch<CryptoStateModel>({sorting}));
  }
  
  @Action(ToggleTokenVisibilityAction)
  toggleTokenVisibilityAction(
    { getState, setState }: StateContext<CryptoStateModel>,
    { tokenId }: ToggleTokenVisibilityAction
  ): void {
    const currentVisibility = getState().tokens.find(token => token.id === tokenId)?.isVisible;
    setState(
      patch<CryptoStateModel>({
        tokens: updateItem<Token>(token => token.id === tokenId, patch({isVisible: !currentVisibility }))
      })
    );
  }

}
