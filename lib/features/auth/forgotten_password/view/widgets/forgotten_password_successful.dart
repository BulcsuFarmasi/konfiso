import 'package:flutter/material.dart';

class ForgottenPasswordSuccessful extends StatelessWidget {
  const ForgottenPasswordSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Email is sent successfully!',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'You can change the password at the page linked in the email.',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          'After that you can login here',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
