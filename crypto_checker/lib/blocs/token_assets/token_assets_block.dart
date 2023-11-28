import 'dart:async';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TokenAssetsBloc extends Bloc<TokenAssetsEvent, TokenAssetsBaseState> {
  final DexScreenerService dexScreenerService;

  TokenAssetsBloc({required this.dexScreenerService}) : super(TokenAssetsState(TokenAssetList.get())) {
    on<FetchTokenDataEvent>(_onFetchTokenDataEvent);
    on<UpdateTokenBagSizeEvent>(_onUpdateTokenBagSizeEvent);
    on<HideTokenEvent>(_onHideTokenEvent);
  }

  Future<void> _onFetchTokenDataEvent(FetchTokenDataEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    try {
      List<Future<void>> fetchTokensData = state.tokens.map((token) async {
        final box = Hive.box<TokenAsset>(HIVE_TOKENASSET_BOX_NAME);
        try {
          final pair = await dexScreenerService.getTokenPair(token).timeout(const Duration(seconds: 5));
          token.price = pair.priceUsd ?? 0.00;
          final tokenFromBox = box.get(token.symbol);
          if (tokenFromBox != null) {
            token.bagSize = tokenFromBox.bagSize;
          }
          await box.put(token.symbol, token);
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
    // I can use save() here because this event handler will always be triggered after at _onFetchTokenDataEvent 
    await token.save();
    emit(TokenAssetsState(state.tokens));
  }

  Future<void> _onHideTokenEvent(HideTokenEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    for ( var token in state.tokens ) {
      if ( token.symbol == ev.symbol ) {
        token.isVisible = false;
        break;
      }
    }
    emit(TokenAssetsState(state.tokens));
  }

}
