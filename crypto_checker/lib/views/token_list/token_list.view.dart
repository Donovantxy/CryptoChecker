import 'package:crypto_checker/views/token_list/widgets/token_list.widget.dart';
import 'package:crypto_checker/widgets/shared/cc_scaffold.widget.dart';
import 'package:flutter/material.dart';

class TokenListView extends StatelessWidget {
  const TokenListView({super.key});

  @override
  Widget build(BuildContext context) {
    return const CcScaffoldWidget(appBarTitle: 'Available tokens', body: TokenListWidget());
  }
}
