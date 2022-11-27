import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/shared/app_colors.dart';

class ForgottenPasswordSuccessful extends ConsumerWidget {
  const ForgottenPasswordSuccessful({super.key});

  void _navigateToSignInPage(BuildContext context, WidgetRef ref) {
    Navigator.of(context).pushReplacementNamed(SignInPage.routeName);

    ref.read(forgottenPasswordPageStateNotifierProvider.notifier).restoreToInitial();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppLocalizations.of(context)!.emailIsSentSuccessfully,
          style: const TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          AppLocalizations.of(context)!.youCanChangeThePasswordAtThePageLinkedInTheEmail,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 5,
        ),
        GestureDetector(
          onTap: () {
            _navigateToSignInPage(context, ref);
          },
          child: Text(
            AppLocalizations.of(context)!.afterThatYouCanLoginHere,
            style: const TextStyle(fontSize: 18, color: AppColors.primaryColor),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
