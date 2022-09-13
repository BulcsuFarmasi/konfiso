import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/model/sign_in_repository.dart';

final signInPageNotiferProvider =
    StateNotifierProvider<SignInPageStateNotifier, SignInPageState>((Ref ref) =>
        SignInPageStateNotifier(ref.read(signInRepositoryProvider)));

class SignInPageStateNotifier extends StateNotifier<SignInPageState> {
  final SignInRepository _signInRepository;

  SignInPageStateNotifier(this._signInRepository) : super(SignInPageInitial());

  void signIn(String email, String password) async {
    state = SignInPageInProgress();
    await _signInRepository.signIn(email, password);
    state = SignInPageSuccessful();
  }
}

abstract class SignInPageState {}

class SignInPageInitial extends SignInPageState {}

class SignInPageInProgress extends SignInPageState {}

class SignInPageSuccessful extends SignInPageState {}
