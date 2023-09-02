import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:konfiso/features/book/book_home/view/pages/book_home_page.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signInPageNotiferProvider, (_, SignInPageState next) {
      switch (next) {
        case Successful():
          Navigator.of(context).pushReplacementNamed(BookHomePage.routeName);
        default:
      }
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(signInPageNotiferProvider);
            return switch(state) {
              Initial() => const SignInInitial(),
              InProgress() => const EntryInProgress(),
              Successful() => const SignInInitial(),
              Error error => SignInError(error: error.error),
            };
          }),
        ),
      ),
    );
  }
}
