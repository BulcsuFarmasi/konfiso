import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user_request_payload.g.dart';

@JsonSerializable()
class UpdateUserRequestPayload {
  final DateTime latestLogin;

  UpdateUserRequestPayload(this.latestLogin);

  Map<String, dynamic> toJson() => _$UpdateUserRequestPayloadToJson(this);
}