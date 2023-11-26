import 'package:crypto_checker/widgets/token_list.widget.dart';
import 'package:crypto_checker/widgets/worth_bar.widget.dart';
import 'package:flutter/material.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Expanded(
          child: TokenListWidget(),
        ),
      ],
    );
  }
}
