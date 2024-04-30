export class LoadTokenQuotesAction {
  public static readonly type = '[Tokens] Load quotes';
}

export class SetTokenBagSizeAction {
  public static readonly type = '[Tokens] Set bag size';
  constructor(public tokenId: number, public bagSize: number) {}
}