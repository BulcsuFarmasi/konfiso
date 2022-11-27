import 'package:flutter/material.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_form.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_info_text.dart';

class ForgottenPasswordInitial extends StatelessWidget {
  const ForgottenPasswordInitial({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        ForgottenPasswordInfoText(),
        SizedBox(
          height: 20,
        ),
        ForgottenPasswordForm(),
      ],
    );
  }
}
