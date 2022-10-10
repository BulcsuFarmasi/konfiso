import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_up/controller/sign_up_page_state.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/features/auth/sign_up/model/sign_up_repository.dart';

final signUpStateNotifierProvider = StateNotifierProvider<SignUpPageStateNotifier, SignUpPageState>(
    (Ref ref) => SignUpPageStateNotifier(ref.read(signUpRepositoryProvider)));

class SignUpPageStateNotifier extends StateNotifier<SignUpPageState> {
  final SignUpRepository _signUpRepository;

  SignUpPageStateNotifier(this._signUpRepository) : super(const SignUpPageState.initial());

  void signUp(String email, String password) async {
    state = const SignUpPageState.inProgress();
    try {
    await _signUpRepository.signUp(email, password);
    state = const SignUpPageState.successful();
    } on SignUpException catch(e) {
      state = SignUpPageState.error(e.error);
    }
  }
}