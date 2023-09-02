import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:konfiso/features/settings/data/settings.dart';

part 'settings_page_state.freezed.dart';

@freezed
sealed class SettingsPageState with _$SettingsPageState{
  const factory SettingsPageState.initial() = Initial;
  const factory SettingsPageState.inProgress() = InProgress;
  const factory SettingsPageState.loadSuccess(Settings settings) = LoadSuccess;
  const factory SettingsPageState.saveSuccess(Settings settings) = SaveSuccess;

}