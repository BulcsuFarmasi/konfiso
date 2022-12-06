import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_initial.dart';
import 'package:konfiso/features/auth/verify_user/view/pages/verify_user_page.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  static const routeName = '/sign-up';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signUpStateNotifierProvider, (_, SignUpPageState next) {
      next.maybeMap(
          successful: (_) {
            ref.read(signUpStateNotifierProvider.notifier).goBackToInitial();
            Navigator.of(context).pushReplacementNamed(VerifyUserPage.routeName);
          },
          orElse: () => null);
    });

    final state = ref.watch(signUpStateNotifierProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: state.maybeMap(
              initial: (_) => const SignUpInitial(),
              inProgress: (_) => const EntryInProgress(),
              error: (error) => SignUpError(error: error.error),
              orElse: () => const SizedBox()),
        ),
      ),
    );
  }
}
