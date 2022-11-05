import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/book/book_home/view/book_home_page.dart';
import 'package:konfiso/features/auth/sign_in/controller/sign_in_page_state_notifier.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/view/widgets/sign_in_initial.dart';
import 'package:konfiso/shared/widgets/entry_in_progress.dart';

class SignInPage extends ConsumerWidget {
  const SignInPage({super.key});

  static const routeName = '/sign-in';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(signInPageNotiferProvider,
        (SignInPageState? previous, SignInPageState next) {
      next.maybeMap(
          successful: (_) {
            Navigator.of(context).pushReplacementNamed(BookHomePage.routeName);
          },
          orElse: () => null);
    });
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(signInPageNotiferProvider);
            return state.map(
                initial: (_) => const SignInInitial(),
                inProgress: (_) => const EntryInProgress(),
                successful: (_) => const SignInInitial(),
                error: (error) => SignInError(error: error.error));
          }),
        ),
      ),
    );
  }
}
