import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_request_payload.freezed.dart';
part 'user_info_request_payload.g.dart';

@freezed
class UserInfoRequestPayload with _$UserInfoRequestPayload {
  const factory UserInfoRequestPayload({required String idToken}) = _UserInfoRequestPayload;

  factory UserInfoRequestPayload.fromJson(Map<String, Object?> json) => _$UserInfoRequestPayloadFromJson(json);
}
