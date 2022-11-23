import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_user_page_state.freezed.dart';

@freezed
class VerifyUserPageState with _$VerifyUserPageState {
  const factory VerifyUserPageState.initial() = _Initial;
  const factory VerifyUserPageState.successful() = _Successful;
}