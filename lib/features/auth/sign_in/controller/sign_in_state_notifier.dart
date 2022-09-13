import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/sign_in/view/pages/sign_in_page.dart';

final signInPageNotiferProvider = StateNotifierProvider((Ref ref) => SignInPageNotifier());

class SignInPageNotifier extends StateNotifier {
  SignInPageNotifier() : super(SignInPageInitial());

  void signIn (String email, String password) {
    state = SignInPageInProgress();
  }
}

abstract class SignInPageState {}

class SignInPageInitial extends SignInPageState {}

class SignInPageInProgress extends SignInPageState {}