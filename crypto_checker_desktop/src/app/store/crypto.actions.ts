import { SortBy, Sorting } from './crypto.state';

export class LoadTokenQuotesAction {
  public static readonly type = '[Tokens] Load quotes';
}

export class SetTokenBagSizeAction {
  public static readonly type = '[Tokens] Set bag size';
  constructor(public tokenId: number, public bagSize: number) {}
}

export class SetSortByAction {
  public static readonly type = '[Tokens] Set sort by';
  constructor(public sortBy: SortBy) {}
}

export class SetSortingAction {
  public static readonly type = '[Tokens] Set sorting';
  constructor(public sorting: Sorting) {}
}

export class ToggleTokenVisibilityAction {
  public static readonly type = '[Tokens] Toggle visibility';
  constructor(public tokenId: number) {}
}