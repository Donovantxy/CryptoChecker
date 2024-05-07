import 'package:crypto_checker/blocs/token_assets/token_assets_block.dart';
import 'package:crypto_checker/blocs/token_assets/token_assets_event.dart';
import 'package:crypto_checker/main.dart';
import 'package:crypto_checker/models/settings.dart';
import 'package:crypto_checker/routes.dart';
import 'package:crypto_checker/services/dexscreener/dexscreener.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SettingsWidget extends StatefulWidget {
  String apiKey = '';
  SettingsWidget({super.key});
  @override
  State<SettingsWidget> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  late final TextEditingController _apiKeyController;
  final coinMarketCapApi = CoinMarketCapService();
  Widget? _resetField;

  Widget getResetFieldIcon(String value) {
    return RegExp(r'.+').hasMatch(value)
        ? IconButton(
            onPressed: () {
              setState(() {
                _apiKeyController.text = '';
              });
            },
            icon: const Icon(Icons.cancel_rounded),
          )
        : const Icon(null);
  }

  
  @override
  void initState() {
    super.initState();
    _apiKeyController = TextEditingController(text: Hive.box<Settings>(HIVE_SETTINGS).get(HIVE_SETTINGS)?.coinMarketCapApiKey ?? Settings().coinMarketCapApiKey);
    _resetField = getResetFieldIcon(_apiKeyController.text);
    initStateAsync();
  }

  Future<void> initStateAsync() async {
  
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Form(
        child: Column(
          children: [
            Column(
              children: [
                const Text('CoinMarketCap Api Key', style: TextStyle(fontSize: 20)),
                TextField(
                  controller: _apiKeyController,
                  decoration: InputDecoration(
                    hintText: '********-****-****-****-************',
                    suffixIcon: _resetField,
                  ),
                  onChanged: (value) {
                    setState(() => _resetField = getResetFieldIcon(value));
                  },
                ),
                TextButton(
                  onPressed: () async {
                    coinMarketCapApi.setKey(_apiKeyController.text);
                    try {
                      await coinMarketCapApi.getTokenQuotes([1]);
                      context.read<TokenAssetsBloc>().add(UpdateApiKeyEvent(_apiKeyController.text));
                      Navigator.of(context).pushReplacementNamed(AppRoutes.walletView);
                    } catch(err) {
                      print('setKey - $err');
                    }
                  },
                  child: const Text('Apply'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
