import 'package:flutter/material.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart' as sign_up_error;
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error_banner.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_form.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignUpError extends StatelessWidget {
  final sign_up_error.SignUpError error;
  final String privacyPolicyUrl;

  const SignUpError({super.key, required this.error, required this.privacyPolicyUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 168,
        ),
        const EntryLogo(),
        const SizedBox(
          height: 32,
        ),
        SignUpErrorBanner(error: error),
        const SizedBox(
          height: 32,
        ),
        SignUpForm(
          privacyPolicyUrl: privacyPolicyUrl,
        ),
      ],
    );
  }
}
