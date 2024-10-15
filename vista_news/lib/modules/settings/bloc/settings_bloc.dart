import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/user/user.dart';
import 'package:vista_news/repositories/auth_repository.dart';
import 'package:vista_news/repositories/news_db_repository.dart';
import 'package:vista_news/utils/theme/app_theme.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final AuthRepository authRepository;
  final NewsDbRepository newsDbRepository;
  SettingsBloc({required this.authRepository, required this.newsDbRepository})
      : super(SettingsState(themeData: AppTheme.lightThemeData)) {
    on<ToggleThemeEvent>(_onToggleThemeEvent);
    on<UpdateUserDataEvent>(_onUpdateUserDataEvent);
    on<LogOutUser>(_onLogOutUser);
  }

  _onToggleThemeEvent(ToggleThemeEvent event, Emitter<SettingsState> emit) {
    if (state.themeData == AppTheme.darkThemeData) {
      emit(SettingsState(user: state.user, themeData: AppTheme.lightThemeData));
    } else {
      emit(SettingsState(user: state.user, themeData: AppTheme.darkThemeData));
    }
  }

  _onUpdateUserDataEvent(
      UpdateUserDataEvent event, Emitter<SettingsState> emit) {
    emit(SettingsState(themeData: state.themeData, user: event.userData));
  }

  _onLogOutUser(LogOutUser event, Emitter<SettingsState> emit) async {
    await authRepository.logOutUser();
    await newsDbRepository.clearNewsDatabase();
  }
}
