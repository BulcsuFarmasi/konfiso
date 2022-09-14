import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/shared/app_colors.dart';

class ErrorBanner extends StatelessWidget {
  final SignInError error;

  const ErrorBanner({super.key, required this.error});

  String _convertErrorToText(SignInError error) {
    switch (error) {
      case SignInError.other:
        return Intl.message('Something went wrong. Please try again later.');
      case SignInError.emailNotFound:
      case SignInError.invalidPassword:
        return Intl.message(
            'Wrong email or password'); // TODO: Handle this case.
      case SignInError.userDisabled:
        return Intl.message('Your account has been disabled.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _convertErrorToText(error),
      style:
          const TextStyle(color: Color(AppColors.primaryColor), fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
