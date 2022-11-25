import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state.dart';
import 'package:konfiso/features/auth/forgotten_password/model/forgotten_password_repository.dart';
import 'package:konfiso/features/auth/forgotten_password/view/pages/forgotten_password_page.dart';

final forgottenPasswordPageStateNotifierProvider =
    StateNotifierProvider<ForgottenPasswordPageStateNotifier, ForgottenPasswordPageState>(
        (Ref ref) => ForgottenPasswordPageStateNotifier(ref.read(forgottenPasswordRepositoryProvider)));

class ForgottenPasswordPageStateNotifier extends StateNotifier<ForgottenPasswordPageState> {
  ForgottenPasswordPageStateNotifier(this._forgottenPasswordRepository)
      : super(const ForgottenPasswordPageState.initial());

  final ForgottenPasswordRepository _forgottenPasswordRepository;

  Future<void> sendEmail() async {
    state = const ForgottenPasswordPageState.inProgress();

    await _forgottenPasswordRepository.sendEmail();

    state = const ForgottenPasswordPageState.successful();
  }
}
