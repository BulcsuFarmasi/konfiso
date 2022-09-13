import 'package:flutter_riverpod/flutter_riverpod.dart';

final signInPageNotiferProvider = StateNotifierProvider((Ref ref) => SignInPageNotifier());

class SignInPageNotifier extends StateNotifier {
  SignInPageNotifier() : super(SignInPageInitial());
}

abstract class SignInPageState {}

class SignInPageInitial extends SignInPageState {}