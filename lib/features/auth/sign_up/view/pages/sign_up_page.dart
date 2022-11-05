import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_initial.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_successful.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static const routeName = '/sign-up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(signUpStateNotifierProvider);
            return state.map(
                initial: (_) => const SignUpInitial(),
                inProgress: (_) => const EntryInProgress(),
                successful: (_) => const SignUpSuccessful(),
                error: (error) => SignUpError(error: error.error));
          }),
        ),
      ),
    );
  }
}
