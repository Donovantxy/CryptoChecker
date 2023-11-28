import 'package:crypto_checker/widgets/shared/cc_drawer.widget.dart';
import 'package:flutter/material.dart';

class CcScaffoldWidget extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  const CcScaffoldWidget({super.key, required this.appBar, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(drawer: const CcDrawerWidget(), appBar: appBar, body: body);
  }
}
