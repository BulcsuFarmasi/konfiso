import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
class AppState  with _$AppState {
  const factory AppState.initial() = _Initial;
  const factory AppState.connected() = _Connected;
  const factory AppState.notConnected() = _NotConnected;
}