import 'package:crypto_checker/widgets/shared/cc_app_bar.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_drawer.widget.dart';
import 'package:flutter/material.dart';

class CcScaffoldWidget extends StatelessWidget {
  final String appBarTitle;
  final Widget body;
  const CcScaffoldWidget({super.key, required this.appBarTitle, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: const CcDrawerWidget(), appBar: CcAppBar.getAppBar(context, appBarTitle), body: body);
  }
}
