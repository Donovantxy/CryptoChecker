import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_state.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/routes.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:crypto_checker/views/wallet.view.dart';
import 'package:crypto_checker/widgets/cc_drawer.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

const HIVE_TOKENASSET_BOX_NAME = 'tokenAsset';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TokenAssetAdapter());
  await Hive.openBox<TokenAsset>(HIVE_TOKENASSET_BOX_NAME);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    TokenAssetsBloc assetBloc = TokenAssetsBloc(dexScreenerService: const DexScreenerService());
    return BlocProvider(
        create: (context) => assetBloc,
        child: MaterialApp(
          routes: AppRoutes.getRoutes(),
          navigatorObservers: [ObserverUtils.routeObserver],
          theme: ThemeData(colorScheme: const ColorScheme.light().copyWith(primary: const Color.fromARGB(255, 2, 97, 118))),
        ));
  }
}

class ObserverUtils {
  static final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
}
