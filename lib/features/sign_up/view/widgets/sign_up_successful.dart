import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignUpLoading extends StatelessWidget {
  const SignUpLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 168,
        ),
        const EntryLogo(),
        const SizedBox(
          height: 64,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(Intl.message('Successful registration, ')),
            Text(Intl.message('now you can login')),
          ],
        ),
      ],
    );
  }
}
