import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
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

class UpdateApiKeyEvent extends TokenAssetsEvent {
  final String apiKey;
  UpdateApiKeyEvent(this.apiKey);
}

class TokenFetchErrorState extends TokenAssetsBaseState {
  final String errorType;
  TokenFetchErrorState(this.errorType, List<TokenAsset> tokens) : super(tokens);
}