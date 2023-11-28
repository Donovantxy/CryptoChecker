abstract class TokenAssetsEvent {}

class LoadTokenAssetsEv extends TokenAssetsEvent {}

class FetchTokenDataEvent extends TokenAssetsEvent {}

class ToggleTokenVisibilityEvent extends TokenAssetsEvent {
  final String symbol;
  ToggleTokenVisibilityEvent(this.symbol);
}

class UpdateTokenBagSizeEvent extends TokenAssetsEvent {
  final String symbol;
  final double amount;
  UpdateTokenBagSizeEvent(this.symbol, this.amount);
}
