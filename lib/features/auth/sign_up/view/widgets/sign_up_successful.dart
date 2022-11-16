import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/shared/app_colors.dart';
import 'package:konfiso/shared/widgets/entry_logo.dart';

class SignUpSuccessful extends ConsumerWidget {
  const SignUpSuccessful({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 168,
        ),
        const EntryLogo(),
        const SizedBox(
          height: 64,
        ),
        Text(
          AppLocalizations.of(context)!.successfulRegistration,
          style: const TextStyle(color: AppColors.greyColor, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        GestureDetector(
          onTap: () {
            ref.read(signUpStateNotifierProvider.notifier).goBackToInitial();
            Navigator.of(context).pushReplacementNamed(SignInPage.routeName);
          },
          child: Text(
            AppLocalizations.of(context)!.nowYouCanLoginHere,
            style:
                const TextStyle(color: AppColors.greyDarkerColor, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
