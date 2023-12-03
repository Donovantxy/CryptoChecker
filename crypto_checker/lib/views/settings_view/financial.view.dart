import 'package:crypto_checker/views/settings_view/widgets/financial.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_scaffold.widget.dart';
import 'package:flutter/material.dart';

class FinancialView extends StatelessWidget {
  const FinancialView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CcScaffoldWidget(appBarTitle: 'Financial', body: FinancialWidget());
  }
}
