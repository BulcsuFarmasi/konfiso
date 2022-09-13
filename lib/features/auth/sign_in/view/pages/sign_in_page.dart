import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(signInPageNotiferProvider);
            if (state is SignInPageInitial) {
              return const SignInInitial();
            } else if (state is SignInPageInProgress) {
              return const EntryInProgress();
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}
