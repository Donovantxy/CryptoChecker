import 'package:crypto_checker/views/settings_view/widgets/settings.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_scaffold.widget.dart';
import 'package:flutter/material.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CcScaffoldWidget(appBarTitle: 'Settings', body: SettingsWidget());
  }
}
