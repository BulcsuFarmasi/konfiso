import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/shared/app_colors.dart';

class VerifyUserSuccessful extends ConsumerWidget {
  const VerifyUserSuccessful({super.key});

  void _navigateToSignInPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const textStyle = TextStyle(color: AppColors.greyColor, fontSize: 20);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 64,
          ),
          Text(
            AppLocalizations.of(context)!.successfulValidation,
            style: textStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              _navigateToSignInPage(context);
            },
            child: Text(
              AppLocalizations.of(context)!.byClickingHereYouCanLogin,
              style: textStyle.copyWith(color: AppColors.primaryColor, fontSize: 24),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
