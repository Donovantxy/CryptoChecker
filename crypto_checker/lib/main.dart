import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/models/financial_record.dart';
import 'package:crypto_checker/routes.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

const HIVE_TOKENASSET_BOX_NAME = 'tokenAsset';
const HIVE_FINANCIAL_BOX_NAME = 'financial';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TokenAssetAdapter());
  Hive.registerAdapter(FinancialRecordAdapter());
  await Hive.openBox<TokenAsset>(HIVE_TOKENASSET_BOX_NAME);
  await Hive.openBox<FinancialRecord>(HIVE_FINANCIAL_BOX_NAME);

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
    assetBloc.add(InitTokenAssetsEvent());
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
