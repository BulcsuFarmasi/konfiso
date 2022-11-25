import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:konfiso/features/auth/forgotten_password/controller/forgotten_password_page_state.dart';

final forgottenPasswordPageStateNotifierProvider = StateNotifierProvider<
        ForgottenPasswordPageStateNotifier, ForgottenPasswordPageState>(
    (Ref ref) => ForgottenPasswordPageStateNotifier());

class ForgottenPasswordPageStateNotifier
    extends StateNotifier<ForgottenPasswordPageState> {
  ForgottenPasswordPageStateNotifier()
      : super(const ForgottenPasswordPageState.initial());
}
