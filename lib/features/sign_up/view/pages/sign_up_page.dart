import 'package:flutter/material.dart';
import 'package:konfiso/features/sign_up/view/widgets/sign_up_initial.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 42),
          child: SignUpInitial(),
        ),
      ),
    );
  }
}
