import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_error.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_repository.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_up_expection.dart';

final signInPageNotiferProvider =
    StateNotifierProvider<SignInPageStateNotifier, SignInPageState>((Ref ref) =>
        SignInPageStateNotifier(ref.read(signInRepositoryProvider)));

class SignInPageStateNotifier extends StateNotifier<SignInPageState> {
  final SignInRepository _signInRepository;

  SignInPageStateNotifier(this._signInRepository) : super(SignInPageInitial());

  void signIn(String email, String password) async {
    state = SignInPageInProgress();
    try {
      await _signInRepository.signIn(email, password);
      state = SignInPageSuccessful();
    } on SignInException catch (e) {
      state = SignInPageError(e.error);
    }
  }
}

abstract class SignInPageState {}

class SignInPageInitial extends SignInPageState {}

class SignInPageInProgress extends SignInPageState {}

class SignInPageSuccessful extends SignInPageState {}

class SignInPageError extends SignInPageState {
  final SignInError error;

  SignInPageError(this.error);
}
