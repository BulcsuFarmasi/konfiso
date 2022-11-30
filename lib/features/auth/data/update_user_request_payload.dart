import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_request_payload.freezed.dart';
part 'update_user_request_payload.g.dart';

@freezed
class UpdateUserRequestPayload with _$UpdateUserRequestPayload {
  const factory UpdateUserRequestPayload(DateTime latestLogin) = _UpdateUserPayload;

  factory UpdateUserRequestPayload.fromJson(Map<String, Object?> json) => _$UpdateUserRequestPayloadFromJson(json);
}
