import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/sign_up/controller/sign_up_state_notifier.dart';
import 'package:konfiso/features/sign_up/view/widgets/sign_up_initial.dart';
import 'package:konfiso/features/sign_up/view/widgets/sign_up_loading.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42),
          child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final state = ref.watch(signUpStateNotifierProvider);
            print(state.runtimeType);
            if (state is SignUpPageInitial) {
              return const SignUpInitial();
            } else if (state is SignUpInProgress) {
              return const SignUpLoading();
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
