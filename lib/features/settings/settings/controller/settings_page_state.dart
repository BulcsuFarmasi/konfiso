import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/settings/data/settings.dart';

part 'settings_page_state.freezed.dart';

@freezed
class SettingsPageState with _$SettingsPageState{
  const factory SettingsPageState.initial() = _Initial;
  const factory SettingsPageState.inProgress() = _InProgress;
  const factory SettingsPageState.loadSuccess(Settings settings) = _LoadSuccess;
  const factory SettingsPageState.saveSuccess(Settings settings) = _SaveSuccess;

}