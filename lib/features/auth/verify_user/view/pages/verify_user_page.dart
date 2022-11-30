import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/verify_user/controller/verify_user_page_state_notifier.dart';
import 'package:konfiso/features/auth/verify_user/view/widgets/verify_user_initial.dart';
import 'package:konfiso/features/auth/verify_user/view/widgets/verify_user_successful.dart';

class VerifyUserPage extends ConsumerStatefulWidget {
  const VerifyUserPage({super.key});

  static const routeName = '/verify-user';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _VerifyUserPageState();
}

class _VerifyUserPageState extends ConsumerState<VerifyUserPage> {
  @override
  void initState() {
    super.initState();

    Future(() {
      ref.read(verifyUserPageStateNotifierProvider.notifier).checkVerification();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(verifyUserPageStateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.verify),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: state.map(initial: (_) => const VerifyUserInitial(), successful: (_) => const VerifyUserSuccessful()),
      ),
    );
  }
}
