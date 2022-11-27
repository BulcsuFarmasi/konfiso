import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_repository.dart';

final forgottenPasswordPageStateNotifierProvider =
    StateNotifierProvider<ForgottenPasswordPageStateNotifier, ForgottenPasswordPageState>(
        (Ref ref) => ForgottenPasswordPageStateNotifier(ref.read(forgottenPasswordRepositoryProvider)));

class ForgottenPasswordPageStateNotifier extends StateNotifier<ForgottenPasswordPageState> {
  ForgottenPasswordPageStateNotifier(this._forgottenPasswordRepository)
      : super(const ForgottenPasswordPageState.initial());

  final ForgottenPasswordRepository _forgottenPasswordRepository;

  Future<void> sendEmail(String email) async {
    state = const ForgottenPasswordPageState.inProgress();

    await _forgottenPasswordRepository.sendEmail(email);

    state = const ForgottenPasswordPageState.successful();
  }

  void restoreToInitial() {
    state = const ForgottenPasswordPageState.initial();
  }
}
