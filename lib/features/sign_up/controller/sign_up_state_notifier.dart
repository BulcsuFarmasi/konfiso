import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpPageStateNotifier extends StateNotifier<SignUpPageState> {
  SignUpPageStateNotifier() : super(SignUpPageInitial());
  void signUp(String email, String password) {
    state = SignUpInProgress();

  }
}

abstract class SignUpPageState {}

class SignUpPageInitial extends SignUpPageState {}

class SignUpInProgress extends SignUpPageState {}

class SignUpError extends SignUpPageState {}

class SignUpSuccessful extends SignUpPageState {}