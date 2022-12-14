import 'package:flutter/material.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignUpInitial extends StatelessWidget {
  const SignUpInitial({super.key, required this.privacyPolicyUrl});

  final String privacyPolicyUrl;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 168,
      ),
      const EntryLogo(),
      const SizedBox(
        height: 64,
      ),
      SignUpForm(
        privacyPolicyUrl: privacyPolicyUrl,
      ),
    ]);
  }
}
