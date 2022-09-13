import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInPageNotiferProvider = StateNotifierProvider((Ref ref) => SignInPageNotifier());

class SignInPageNotifier extends StateNotifier {
  SignInPageNotifier() : super(SignInPageInitial());

  void signIn (String email, String password) {

  }
}

abstract class SignInPageState {}

class SignInPageInitial extends SignInPageState {}