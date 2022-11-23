import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/verify_user/controller/verify_user_page_state.dart';

final verifyUserPageStateNotifierProvider =
    StateNotifierProvider<VerifyUserPageStateNotifier, VerifyUserPageState>(
        (Ref ref) => VerifyUserPageStateNotifier());

class VerifyUserPageStateNotifier extends StateNotifier<VerifyUserPageState> {
  VerifyUserPageStateNotifier() : super(const VerifyUserPageState.initial());

  void checkVerification() {}
}
