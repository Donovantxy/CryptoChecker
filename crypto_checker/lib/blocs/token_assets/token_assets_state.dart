import 'package:crypto_checker/models/asset_token.dart';
import 'package:equatable/equatable.dart';

abstract class TokenAssetsBaseState {
  final List<TokenAsset> tokens;
  TokenAssetsBaseState(this.tokens);
}

class TokenAssetsState extends TokenAssetsBaseState {
  TokenAssetsState(List<TokenAsset> tokens) : super(tokens);
}
