import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TokenAssetsBloc extends Bloc<TokenAssetsEvent, TokenAssetsState> {
  final DexScreenerService dexScreenerService;

  TokenAssetsBloc({required this.dexScreenerService}) : super(TokenAssetsInitialSt()) {
    on<UpdateTokenAssetPricesEv>(_onUpdateTokenAssetPricesEv);
  }

  Future<void> _onUpdateTokenAssetPricesEv(UpdateTokenAssetPricesEv ev, Emitter<TokenAssetsState> emit) async {
    emit(UpdatingTokenAssetPricesSt((state as UpdateTokenAssetPricesEv).symbol));
  }
}
