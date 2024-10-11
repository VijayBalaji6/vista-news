// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class ToggleThemeEvent extends SettingsEvent {}

class UpdateUserDataEvent extends SettingsEvent {
  final User userData;
  const UpdateUserDataEvent({
    required this.userData,
  });
}

class LogOutUser extends SettingsEvent {}
