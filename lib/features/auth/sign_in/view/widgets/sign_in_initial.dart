import 'package:flutter/material.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_form.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignInInitial extends StatelessWidget {
  const SignInInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: const [
      SizedBox(
        height: 168,
      ),
      EntryLogo(),
      SizedBox(
        height: 64,
      ),
      SignInForm(),
    ]);
  }
}
