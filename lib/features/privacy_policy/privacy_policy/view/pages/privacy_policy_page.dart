import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/privacy_policy/privacy_policy/controller/privacy_policy_page_state.dart';
import 'package:konfiso/features/privacy_policy/privacy_policy/controller/privacy_policy_page_state_notifier.dart';
import 'package:konfiso/features/privacy_policy/privacy_policy/view/widgets/privacy_policy_successful.dart';

class PrivacyPolicyPage extends ConsumerStatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  ConsumerState<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends ConsumerState<PrivacyPolicyPage> {
  @override
  void initState() {
    super.initState();
    Future(() {
      ref.read(privacyPolicyPageStateNotifierProvider.notifier).loadPrivacyPolicyUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(
        builder: (_, WidgetRef ref, __) {
          final state = ref.watch(privacyPolicyPageStateNotifierProvider);

          return switch (state) {
            Successful successful => PrivacyPolicySuccessful(successful.privacyPolicyUrl),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
