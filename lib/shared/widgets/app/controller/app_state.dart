import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_state.freezed.dart';

@freezed
sealed class AppState with _$AppState {
  const factory AppState.initial() = Initial;

  const factory AppState.connected() = Connected;

  const factory AppState.notConnected() = NotConnected;

  const factory AppState.lightMode() = LightMode;

  const factory AppState.darkMode() = DarkMode;
}
