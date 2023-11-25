abstract class TokenAssetsEvent {}

class LoadTokenAssetsEv extends TokenAssetsEvent {}

class FetchTokenDataEvent extends TokenAssetsEvent {}

class UpdateTokenBagSizeEvent extends TokenAssetsEvent {
  final String symbol;
  final double amount;
  UpdateTokenBagSizeEvent(this.symbol, this.amount);
}
