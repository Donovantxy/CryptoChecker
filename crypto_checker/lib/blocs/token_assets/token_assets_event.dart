import 'package:crypto_checker/models/settings.dart';

abstract class TokenAssetsEvent {}

class InitTokenAssetsEvent extends TokenAssetsEvent {}

class FetchTokenDataEvent extends TokenAssetsEvent {}

class UpdateSortingByEvent extends TokenAssetsEvent {
  final OrderBy orderBy;
  UpdateSortingByEvent(this.orderBy);
}

class UpdateSortingOrderTokensEvent extends TokenAssetsEvent {}

class ToggleTokenVisibilityEvent extends TokenAssetsEvent {
  final String symbol;
  ToggleTokenVisibilityEvent(this.symbol);
}

class UpdateTokenBagSizeEvent extends TokenAssetsEvent {
  final String symbol;
  final double amount;
  UpdateTokenBagSizeEvent(this.symbol, this.amount);
}
