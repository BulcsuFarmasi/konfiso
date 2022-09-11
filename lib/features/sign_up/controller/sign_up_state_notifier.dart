import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/sign_up/model/sign_up_repository.dart';

final signUpStateNotifierProvider = StateNotifierProvider((Ref ref) => SignUpPageStateNotifier(ref.read(signUpRepositoryProvider)));

class SignUpPageStateNotifier extends StateNotifier<SignUpPageState> {
  final SignUpRepository _signUpRepository;
  SignUpPageStateNotifier(this._signUpRepository) : super(SignUpPageInitial());
  void signUp(String email, String password) async {
    state = SignUpInProgress();
    await _signUpRepository.signUp(email, password);
    state = SignUpSuccessful();
  }
}

abstract class SignUpPageState {}

class SignUpPageInitial extends SignUpPageState {}

class SignUpInProgress extends SignUpPageState {}

class SignUpError extends SignUpPageState {}

class SignUpSuccessful extends SignUpPageState {}