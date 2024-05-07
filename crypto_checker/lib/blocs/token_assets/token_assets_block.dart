import 'dart:async';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/settings.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class TokenAssetsBloc extends Bloc<TokenAssetsEvent, TokenAssetsBaseState> {
  final CoinMarketCapService coinMarketCapApi;
  final box = Hive.box<TokenAsset>(HIVE_TOKENASSET_BOX_NAME);
  final settingsBox = Hive.box<Settings>(HIVE_SETTINGS);
  late Settings settings;

  TokenAssetsBloc({required this.coinMarketCapApi}) : super(TokenAssetsState([])) {
    settings = settingsBox.get(HIVE_SETTINGS) ?? Settings();
    settingsBox.put(HIVE_SETTINGS, settings);
    on<InitTokenAssetsEvent>(_onInitTokenAssetsEvent);
    on<UpdateSortingByEvent>(_onUpdateSortingByEvent);
    on<UpdateSortingOrderTokensEvent>(_onUpdateSortingOrderTokensEvent);
    on<FetchTokenDataEvent>(_onFetchTokenDataEvent);
    on<UpdateTokenBagSizeEvent>(_onUpdateTokenBagSizeEvent);
    on<ToggleTokenVisibilityEvent>(_onToggleTokenVisibilityEvent);
    on<UpdateApiKeyEvent>(_onUpdateApiKeyEvent);
  }

  Future<void> applySettings() async {
    switch (settings.orderBy) {
      case OrderBy.price:
        TokenAsset.sortByPrice(state.tokens, isAsc: settings.sortingOrder);
        break;
      case OrderBy.bagSize:
        TokenAsset.sortByAmount(state.tokens, isAsc: settings.sortingOrder);
        break;
      case OrderBy.symbol:
        TokenAsset.sortBySymbol(state.tokens, isAsc: settings.sortingOrder);
        break;
      case OrderBy.percD:
        TokenAsset.sortByPerc(state.tokens, Percentages.daily, isAsc: settings.sortingOrder);
        break;
      case OrderBy.percW:
        TokenAsset.sortByPerc(state.tokens, Percentages.weekly, isAsc: settings.sortingOrder);
        break;
      case OrderBy.percM:
        TokenAsset.sortByPerc(state.tokens, Percentages.monthly, isAsc: settings.sortingOrder);
        break;
      case OrderBy.capital:
        TokenAsset.sortByCapital(state.tokens, isAsc: settings.sortingOrder);
        break;
      default:
        throw Exception('Error - applySettings() > switch');
    }
  }

  Future<void> _onInitTokenAssetsEvent(InitTokenAssetsEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    // await box.clear();
    TokenAssetList.get().forEach((token) {
      var tokenFromBox = box.get(token.symbol);
      if (tokenFromBox != null) {
        token.bagSize = tokenFromBox.bagSize;
        token.isVisible = tokenFromBox.isVisible;
      }
      state.tokens.add(token);
    });

    await applySettings();
    emit(TokenAssetsState(state.tokens));
  }

  Future<void> _onUpdateSortingByEvent(UpdateSortingByEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    if (settings.orderBy != ev.orderBy) {
      settings.orderBy = ev.orderBy;
      await settings.save();
      await applySettings();
      emit(TokenAssetsState(state.tokens));
    }
  }

  Future<void> _onUpdateSortingOrderTokensEvent(UpdateSortingOrderTokensEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    settings.sortingOrder = settings.sortingOrder == SortingOrder.asc ? SortingOrder.desc : SortingOrder.asc;
    await settings.save();
    await applySettings();
    emit(TokenAssetsState(state.tokens));
  }
  
  Future<void> _onUpdateApiKeyEvent(UpdateApiKeyEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    settings.coinMarketCapApiKey = ev.apiKey;
    await settings.save();
    emit(TokenAssetsState(state.tokens));
  }

  Future<void> _onFetchTokenDataEvent(FetchTokenDataEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    try {
      final tokens = state.tokens;
      print('_onFetchTokenDataEvent - ${CoinMarketCapService.COIN_MARKET_CAP_API_KEY}');
      final quotes = await coinMarketCapApi.getTokenQuotes(tokens.map((e) => e.id).toList()).timeout(const Duration(seconds: 5));
      quotes?.forEach((String key, quote) async {
        final tokenFromBox = box.get(tokens.where((token) => token.id == quote.id).first.symbol);
        final token = tokens.firstWhere((token) => token.id == quote.id);
        if (tokenFromBox != null) {
          if( token != null ) {
            token.bagSize = tokenFromBox.bagSize;
            token.isVisible = tokenFromBox.isVisible;
            token.price = quote.usd;
            token.percentageD = quote.percDay;
            token.percentageW = quote.percWeek;
            token.percentageM = quote.percMonth;
          }
        } 
        await box.put(token.symbol, token);
      });
    } catch (err) {
      // print('_onFetchTokenDataEvent - $err');
      emit(TokenFetchErrorState('onFetchError', state.tokens));
    }
      
    try {
      TokenAsset.sortByPrice(state.tokens);
      applySettings();
      emit(TokenAssetsState(state.tokens));
    } catch (err) {
      // some sort of error toast
      applySettings();
      TokenAsset.sortByPrice(state.tokens);
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

  Future<void> _onToggleTokenVisibilityEvent(ToggleTokenVisibilityEvent ev, Emitter<TokenAssetsBaseState> emit) async {
    TokenAsset token = state.tokens.firstWhere((token) => token.symbol == ev.symbol);
    if (token.symbol == ev.symbol) {
      token.isVisible = !token.isVisible;
      await token.save();
    }
    emit(TokenAssetsState(state.tokens));
  }
}
