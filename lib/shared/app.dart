import 'package:flutter/material.dart';
import 'package:konfiso/features/sign_up/view/sign_up_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Konfiso',
      home: SignUpPage(),
    );
  }
}
