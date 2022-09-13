import 'package:flutter/material.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignUpInProgress extends StatelessWidget {
  const SignUpInProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 168,
        ),
        EntryLogo(),
        SizedBox(
          height: 64,
        ),
        CircularProgressIndicator(),
      ],
    );
  }
}
