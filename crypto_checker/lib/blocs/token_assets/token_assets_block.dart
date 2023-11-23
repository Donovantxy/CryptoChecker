import 'dart:async';

import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenAssetsBloc extends Bloc<TokenAssetsEvent, TokenAssetsBaseState> {
  final DexScreenerService dexScreenerService;

  TokenAssetsBloc({required this.dexScreenerService}) : super(TokenAssetsState(TokenAssetList.get())) {
    _pollingTokenPair();
    on<UpdateTokenAssetPricesEv>(_onUpdateTokenAssetPricesEv);
  }

  Future<void> _onUpdateTokenAssetPricesEv(UpdateTokenAssetPricesEv ev, Emitter<TokenAssetsBaseState> emit) async {
    final indexToken = state.tokens.indexWhere((token) => token.symbol == ev.symbol);
    final tokenPair = await dexScreenerService.getTokenPair(state.tokens[indexToken]);
    state.tokens[indexToken].price = tokenPair.priceUsd ?? 0.00;
    emit(TokenAssetsState(state.tokens));
  }

  void _pollingTokenPair() {
    Timer.periodic(const Duration(seconds: 5), (_) {
      // add(UpdateTokenAssetPricesEv());
    });
  }
}
