import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vista_news/models/user/user.dart';
import 'package:vista_news/modules/settings/bloc/settings_bloc.dart';
import 'package:vista_news/repositories/auth_repository.dart';
import 'package:vista_news/repositories/news_db_repository.dart';
import 'package:vista_news/utils/theme/app_theme.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockNewsDbRepository extends Mock implements NewsDbRepository {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SettingsBloc settingsBloc;
  late MockAuthRepository mockAuthRepository;
  late MockNewsDbRepository mockNewsDbService;

  final user = User(userName: 'Vijay', favNewsCategory: [], city: null);

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    mockNewsDbService = MockNewsDbRepository();
    settingsBloc = SettingsBloc(
        authRepository: mockAuthRepository,
        newsDbRepository: mockNewsDbService);
  });

  group('SettingsBloc', () {
    blocTest<SettingsBloc, SettingsState>(
      'Test Dark theme change event',
      build: () => settingsBloc,
      seed: () => SettingsState(themeData: AppTheme.darkThemeData),
      act: (bloc) => bloc.add(ToggleThemeEvent()),
      expect: () => [
        SettingsState(themeData: AppTheme.lightThemeData),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'Test light theme change event',
      build: () => settingsBloc,
      seed: () => SettingsState(themeData: AppTheme.lightThemeData),
      act: (bloc) => bloc.add(ToggleThemeEvent()),
      expect: () => [
        SettingsState(themeData: AppTheme.darkThemeData),
      ],
    );

    blocTest<SettingsBloc, SettingsState>(
      'Update User data event test',
      build: () => settingsBloc,
      act: (bloc) {
        bloc.add(UpdateUserDataEvent(userData: user));
      },
      expect: () => [
        SettingsState(
          themeData: AppTheme.lightThemeData,
          user: user,
        ),
      ],
    );
    blocTest<SettingsBloc, SettingsState>(
      'calls logOutUser and clearDatabase when LogOutUser is added',
      build: () {
        when(() => mockAuthRepository.logOutUser())
            .thenAnswer((_) async => true);
        when(() => mockNewsDbService.clearNewsDatabase())
            .thenAnswer((_) async => true);
        return settingsBloc;
      },
      act: (bloc) async {
        bloc.add(LogOutUser());
      },
      verify: (_) {
        verify(() => mockAuthRepository.logOutUser()).called(1);
        verify(() => mockNewsDbService.clearNewsDatabase()).called(1);
      },
      expect: () => [],
    );
  });
}
