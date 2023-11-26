abstract class TokenAssetsEvent {}

class LoadTokenAssetsEv extends TokenAssetsEvent {}

class FetchTokenDataEvent extends TokenAssetsEvent {}

class HideTokenEvent extends TokenAssetsEvent {
  final String symbol;
  HideTokenEvent(this.symbol);
}

class UpdateTokenBagSizeEvent extends TokenAssetsEvent {
  final String symbol;
  final double amount;
  UpdateTokenBagSizeEvent(this.symbol, this.amount);
}
