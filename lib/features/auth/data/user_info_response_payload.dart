import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/auth/data/user_info.dart';

part 'user_info_response_payload.freezed.dart';
part 'user_info_response_payload.g.dart';

@freezed
class UserInfoResponsePayload with _$UserInfoResponsePayload {
  const factory UserInfoResponsePayload({required List<UserInfo> users}) = _UserInfoResponsePayload;

  factory UserInfoResponsePayload.fromJson(Map<String, Object?> json) => _$UserInfoResponsePayloadFromJson(json);
}
