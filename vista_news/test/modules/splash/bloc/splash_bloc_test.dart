import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vista_news/models/user/user.dart';
import 'package:vista_news/modules/splash/bloc/splash_bloc.dart';
import 'package:vista_news/repositories/auth_repository.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

final mockUser = User(userName: "vijay", favNewsCategory: []);
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late SplashBloc splashBloc;
  late AuthRepository mockAuthRepository;
  group('SplashBloc', () {
    setUp(() {
      mockAuthRepository = MockAuthRepository();
      splashBloc = SplashBloc(authRepository: mockAuthRepository);
    });

    blocTest<SplashBloc, SplashState>(
      'Test Already registered Flow',
      seed: () => SplashInitial(),
      build: () {
        when(() => mockAuthRepository.getLoggedInUser())
            .thenAnswer((_) async => mockUser);
        return splashBloc;
      },
      act: (bloc) => bloc.add(CheckIsUserRegisteredEvent()),
      expect: () => [RegisteredState(registerUserData: mockUser)],
    );

    blocTest<SplashBloc, SplashState>(
      'Test no user Flow',
      seed: () => SplashInitial(),
      build: () {
        when(() => mockAuthRepository.getLoggedInUser())
            .thenAnswer((_) async => null);
        return splashBloc;
      },
      act: (bloc) => bloc.add(CheckIsUserRegisteredEvent()),
      expect: () => [UnRegisteredState()],
    );
  });
}
