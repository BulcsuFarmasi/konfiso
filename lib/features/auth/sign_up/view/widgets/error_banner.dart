import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_error.dart';
import 'package:konfiso/shared/app_colors.dart';

class ErrorBanner extends StatelessWidget {
  final SignUpError error;

  const ErrorBanner({super.key, required this.error});

  String _convertErrorToText(SignUpError error) {
    switch (error) {
      case SignUpError.emailExits:
        return Intl.message(
            'This email address is already registred. Please try an another.');
      case SignUpError.operationNotAllowed:
        return Intl.message('This operation is not allowed.');
      case SignUpError.tooManyAttempts:
        return Intl.message(
            'You were trying too many times, please try again some time later.');
      case SignUpError.other:
        return Intl.message('Something went wrong. Please try again later.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _convertErrorToText(error),
      style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
