abstract class TokenAssetsEvent {}

class LoadTokenAssetsEv extends TokenAssetsEvent {}

class UpdateTokenAssetPricesEv extends TokenAssetsEvent {
  final String symbol;
  UpdateTokenAssetPricesEv(this.symbol);
}

class UpdatingTokenAssetPricesEv extends TokenAssetsEvent {}

class UpdatedTokenAssetPricesEv extends TokenAssetsEvent {}
