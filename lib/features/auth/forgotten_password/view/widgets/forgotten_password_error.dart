import 'package:flutter/material.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_error.dart'
    as forgotten_password_error;
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_error_banner.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_form.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_info_text.dart';

class ForgottenPasswordError extends StatelessWidget {
  const ForgottenPasswordError({super.key, required this.error, required this.email});

  final forgotten_password_error.ForgottenPasswordError error;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ForgottenPasswordInfoText(),
        const SizedBox(
          height: 20,
        ),
        ForgottenPasswordErrorBanner(error: error),
        const SizedBox(
          height: 20,
        ),
        ForgottenPasswordForm(email: email),
      ],
    );
  }
}
