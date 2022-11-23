import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/verify_user/controller/verify_user_page_state_notifier.dart';
import 'package:konfiso/features/auth/verify_user/view/widgets/verify_user_initial.dart';
import 'package:konfiso/features/auth/verify_user/view/widgets/verify_user_successful.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VerifyUserPage extends ConsumerWidget {
  const VerifyUserPage({super.key});

  static const routeName = '/verify-user';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.verifyUser),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Consumer(builder: (_, WidgetRef ref, __) {
          final state = ref.watch(verifyUserPageStateNotifierProvider);
          return state.map(
              initial: (_) => const VerifyUserInitial(),
              successful: (_) => const VerifyUserSuccessful());
        }),
      ),
    );
  }
}
