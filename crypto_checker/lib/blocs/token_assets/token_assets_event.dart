abstract class TokenAssetsEvent {}

class LoadTokenAssetsEv extends TokenAssetsEvent {}

class UpdateTokenAssetPricesEv extends TokenAssetsEvent {
  final String symbol;
  UpdateTokenAssetPricesEv(this.symbol);
}
