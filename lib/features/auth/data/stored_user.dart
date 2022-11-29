import 'package:freezed_annotation/freezed_annotation.dart';

part 'stored_user.freezed.dart';

part 'stored_user.g.dart';

@freezed
class StoredUser with _$StoredUser {
  const factory StoredUser({
    required String authId,
    required String token,
    required String refreshToken,
    required DateTime validUntil,
    required bool verified,
    String? userId,
  }) = _StoredUser;

  factory StoredUser.fromJson(Map<String, Object?> json) => _$StoredUserFromJson(json);
}
