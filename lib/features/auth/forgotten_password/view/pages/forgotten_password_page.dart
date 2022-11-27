import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state_notifier.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_error.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_in_progress.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_initial.dart';
import 'package:konfiso/features/auth/forgotten_password/view/widgets/forgotten_password_successful.dart';

class ForgottenPasswordPage extends ConsumerWidget {
  const ForgottenPasswordPage({super.key});

  static const routeName = '/forgotten-password';

  void _navigateBack(BuildContext context, WidgetRef ref) {
    Navigator.of(context).pop();

    ref.read(forgottenPasswordPageStateNotifierProvider.notifier).restoreToInitial();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(forgottenPasswordPageStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forgotPassword),
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            _navigateBack(context, ref);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: state.map(
            initial: (_) => const ForgottenPasswordInitial(),
            inProgress: (_) => const ForgottenPasswordInProgress(),
            successful: (_) => const ForgottenPasswordSuccessful(),
            error: (error) => ForgottenPasswordError(error: error.error, email: error.email)),
      ),
    );
  }
}
