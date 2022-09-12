import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/sign_up/view/pages/sign_up_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  static const routeName = '/sign-in';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  void _navigateToSignUp() {
    Navigator.of(context).pushReplacementNamed(SignUpPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: _navigateToSignUp,
          child: Text(Intl.message('sign up')),
        ),
      ),
    );
  }
}
