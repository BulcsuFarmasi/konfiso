import 'package:flutter/material.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart' as sign_in_error;
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error_banner.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_form.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignInError extends StatelessWidget {
  final sign_in_error.SignInError error;

  const SignInError({super.key, required this.error});

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
        SignInErrorBanner(error: error),
        const SizedBox(
          height: 32,
        ),
        const SignInForm(),
      ],
    );
  }
}
