import 'package:flutter/material.dart';
import 'package:konfiso/features/sign_up/view/widgets/sign_up_form.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignUpInitial extends StatelessWidget {
  const SignUpInitial({
    Key? key,
  }) : super(key: key);

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
      SignUpForm(),
    ]);
  }
}