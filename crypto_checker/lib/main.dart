import 'package:crypto_checker/views/main.view.dart';
import 'package:crypto_checker/widgets/token_list.widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Crypto checker")),
        body: const MainView()
      ),
    );
  }
}
