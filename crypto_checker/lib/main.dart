import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/models/asset_token.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:crypto_checker/views/main.view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

const HIVE_TOKENASSET_BOX_NAME = 'tokenAsset';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TokenAssetAdapter());
  await Hive.openBox<TokenAsset>(HIVE_TOKENASSET_BOX_NAME);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TokenAssetsBloc(dexScreenerService: const DexScreenerService()),
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text("Crypto checker")),
            body: const MainView(),
          ),
        ));
  }
}
