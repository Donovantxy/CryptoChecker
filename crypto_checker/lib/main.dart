import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late DexScreenerService dexService;

  @override
  void initState() {
    super.initState();
    dexService = new DexScreenerService();
    dexService.getTokenPair('WPLS').then((value) => {print(value)});
  }

  @override
  Widget build(BuildContext context) {
    // var response = await (new DexScreenerService()).getToken('PLS');
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
