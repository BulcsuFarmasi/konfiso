import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/verify_user/controller/verify_user_page_state.dart';
import 'package:konfiso/features/auth/verify_user/model/verify_user_repository.dart';

final verifyUserPageStateNotifierProvider = StateNotifierProvider<
        VerifyUserPageStateNotifier, VerifyUserPageState>(
    (Ref ref) =>
        VerifyUserPageStateNotifier(ref.read(verifyUserRepositoryProvider)));

class VerifyUserPageStateNotifier extends StateNotifier<VerifyUserPageState> {
  VerifyUserPageStateNotifier(this._verifyUserRepository)
      : super(const VerifyUserPageState.initial());

  final VerifyUserRepository _verifyUserRepository;

  Future<void> checkVerification() async {
    await _verifyUserRepository.checkVerification();

    state = const VerifyUserPageState.successful();
  }

  Future<void> resendVerificationEmail() async {}
}
