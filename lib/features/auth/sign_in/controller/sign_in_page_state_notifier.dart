import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/controller/sing_in_page_state.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_repository.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_up_expection.dart';

final signInPageNotiferProvider =
    StateNotifierProvider<SignInPageStateNotifier, SignInPageState>((Ref ref) =>
        SignInPageStateNotifier(ref.read(signInRepositoryProvider)));

class SignInPageStateNotifier extends StateNotifier<SignInPageState> {
  final SignInRepository _signInRepository;

  SignInPageStateNotifier(this._signInRepository) : super(const SignInPageState.initial());

  void signIn(String email, String password) async {
    state = const SignInPageState.inProgress();
    try {
      await _signInRepository.signIn(email, password);
      state = const SignInPageState.successful();
    } on SignInException catch (e) {
      state = SignInPageState.error(e.error);
    }
  }
}


