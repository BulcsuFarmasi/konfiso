import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/shared/app_colors.dart';

abstract class ErrorBanner<T> extends ConsumerWidget {
  final T error;

  const ErrorBanner({super.key, required this.error});

  String convertErrorToText(BuildContext context);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors appColors = ref.read(appColorsProvider);
    return Text(
      convertErrorToText(context),
      style: TextStyle(color: appColors.primaryColor, fontSize: 20),
      textAlign: TextAlign.center,
    );
  }
}
