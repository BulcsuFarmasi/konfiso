import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/sign_up/model/sign_up_exception.dart';
import 'package:konfiso/features/sign_up/model/sign_up_repository.dart';
import 'package:konfiso/features/sign_up/model/sign_up_error.dart';

final signUpStateNotifierProvider = StateNotifierProvider(
    (Ref ref) => SignUpPageStateNotifier(ref.read(signUpRepositoryProvider)));

class SignUpPageStateNotifier extends StateNotifier<SignUpPageState> {
  final SignUpRepository _signUpRepository;

  SignUpPageStateNotifier(this._signUpRepository) : super(SignUpPageInitial());

  void signUp(String email, String password) async {
    state = SignUpPageInProgress();
    try {
    await _signUpRepository.signUp(email, password);
    state = SignUpPageSuccessful();
    } on SignUpException catch(e) {
      state = SignUpPageError(e.error);
    }
  }
}

abstract class SignUpPageState {}

class SignUpPageInitial extends SignUpPageState {}

class SignUpPageInProgress extends SignUpPageState {}

class SignUpPageError extends SignUpPageState {
  final SignUpError error;

  SignUpPageError(this.error);
}

class SignUpPageSuccessful extends SignUpPageState {}
