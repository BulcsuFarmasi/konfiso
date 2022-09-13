import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_state_notifier.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_error.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_initial.dart';
import 'package:konfiso/features/auth/sign_up/view/widgets/sign_up_loading.dart';
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
          child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(signUpStateNotifierProvider);
            if (state is SignUpPageInitial) {
              return const SignUpInitial();
            } else if (state is SignUpPageInProgress) {
              return const SignUpInProgress();
            } else if (state is  SignUpPageSuccessful) {
              return const SignUpSuccessful();
            } else if (state is SignUpPageError) {
              return SignUpError(error: state.error);
            }
            else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}
