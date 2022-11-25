import 'package:flutter/material.dart';

class ForgottenPasswordInfoText extends StatelessWidget {
  const ForgottenPasswordInfoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        'Please provide your e-mail address below, so we can send the email with which you can set a new password', textAlign: TextAlign.center,);
  }
}
