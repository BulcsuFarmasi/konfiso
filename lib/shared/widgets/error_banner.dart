import 'package:flutter/material.dart';
import 'package:konfiso/shared/app_colors.dart';

abstract class ErrorBanner<T> extends StatelessWidget {
  final T error;

  const ErrorBanner({super.key, required this.error});

  String convertErrorToText(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Text(
      convertErrorToText(context),
      style: const TextStyle(color: AppColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}