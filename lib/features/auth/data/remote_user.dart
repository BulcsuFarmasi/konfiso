import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_user.freezed.dart';
part 'remote_user.g.dart';

@freezed
class RemoteUser with _$RemoteUser {
  const factory RemoteUser({
    String? id,
    required String authId,
    required String email,
    required DateTime registrationDate,
    required bool consented,
    required String consentUrl,
    DateTime? latestLogin,
  }) = _RemoteUser;

  factory RemoteUser.fromJson(Map<String, Object?> json) => _$RemoteUserFromJson(json);
}
