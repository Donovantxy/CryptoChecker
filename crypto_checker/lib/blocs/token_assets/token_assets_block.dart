import 'dart:async';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenAssetsBloc extends Bloc<TokenAssetsEvent, TokenAssetsBaseState> {
  final DexScreenerService dexScreenerService;

  TokenAssetsBloc({required this.dexScreenerService}) : super(TokenAssetsState(TokenAssetList.get())) {
    on<FetchTokenDataEvent>(_onFetchTokenDataEvent);
    on<UpdateTokenBagSizeEvent>(_onUpdateTokenBagSizeEvent);
  }

  Future<void> _onFetchTokenDataEvent(FetchTokenDataEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    try {
      List<Future<void>> fetchTokensData = state.tokens.map((token) async {
        try {
          final pair = await dexScreenerService.getTokenPair(token).timeout(const Duration(seconds: 5));
          token.price = pair.priceUsd ?? 0.00;
        } catch (err) {
          // some sort of error toast
        }
      }).toList();
      await Future.wait(fetchTokensData);
      emit(TokenAssetsState(state.tokens));
    } catch (err) {
      // some sort of error toast
      emit(TokenAssetsState(state.tokens));
    }
  }

  Future<void> _onUpdateTokenBagSizeEvent(UpdateTokenBagSizeEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    TokenAsset token = state.tokens.firstWhere((token) => token.symbol == ev.symbol);
    token.bagSize = ev.amount;
    emit(TokenAssetsState(state.tokens));
  }

  // Future<int> _getBagSizeFromPrefs() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getInt(widget.tokenAsset.symbol) ?? -1;
  // }
}
