import 'package:crypto_checker/models/asset_token.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorthBarWidget extends StatefulWidget {
  const WorthBarWidget({super.key});

  @override
  State<WorthBarWidget> createState() => _WorthBarWidgetState();
}

class _WorthBarWidgetState extends State<WorthBarWidget> {

  

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: <Widget>[
        Text('Worth'),
      ],
    );
  }

  @override
  void initState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    TokenAssetList.get().forEach((element) {
      
    });
    super.initState();
  }

}
