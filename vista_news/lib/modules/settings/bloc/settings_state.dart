part of 'settings_bloc.dart';

class SettingsState extends Equatable {
  final ThemeData themeData;
  final User? user; // Nullable user

  const SettingsState({
    required this.themeData,
    this.user,
  });

  @override
  List<Object?> get props => [themeData, user];
}
