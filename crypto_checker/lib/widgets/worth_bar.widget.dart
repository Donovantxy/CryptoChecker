import 'package:flutter/material.dart';

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
  void initState() {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // TokenAssetList.get().forEach((element) {
      
    // });
    super.initState();
  }

}
