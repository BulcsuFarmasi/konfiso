import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/shared/app_colors.dart';

class VerifyUserSuccessful extends StatelessWidget {
  const VerifyUserSuccessful({super.key});

  void _navigateToSignInPage(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
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
              AppLocalizations.of(context)!.nowYouCanLoginHere,
              style: textStyle.copyWith(color: AppColors.greyDarkestColor),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Text(
            AppLocalizations.of(context)!.ifYourValidationCodeIsExpiredYouCanResendTheEmailWithTheButtonBelow,
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text(AppLocalizations.of(context)!.resendEmail),
          )
        ],
      ),
    );
  }
}
