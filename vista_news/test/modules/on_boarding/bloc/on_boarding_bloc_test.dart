import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vista_news/models/location/location.dart';
import 'package:vista_news/models/user/user.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';
import 'package:vista_news/repositories/auth_repository.dart';
import 'package:vista_news/repositories/location_repository.dart';

class MockLocationRepository extends Mock implements LocationRepository {}

class MockAuthRepository extends Mock implements AuthRepository {}

final mockUser = User(userName: "vijay", favNewsCategory: [], city: 'Madurai');

final mockUserLocationData = Location(city: 'Madurai');

final mockPosition = Position(
  latitude: 10.0,
  longitude: 20.0,
  accuracy: 10.0,
  timestamp: DateTime.now(),
  altitude: 0,
  speed: 0,
  heading: 0,
  floor: 0,
  altitudeAccuracy: 1.0,
  headingAccuracy: 1.0,
  speedAccuracy: 1.0,
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('OnBoardingBloc', () {
    late OnBoardingBloc onBoardingBloc;
    late MockLocationRepository mockLocationService;
    late MockAuthRepository mockAuthRepo;

    setUp(() {
      mockLocationService = MockLocationRepository();
      mockAuthRepo = MockAuthRepository();
      onBoardingBloc = OnBoardingBloc(
          locationRepository: mockLocationService,
          authRepository: mockAuthRepo);
    });

    tearDown(() {
      onBoardingBloc.close();
    });

    test('initial state is NameStep', () {
      expect(onBoardingBloc.state, const NameStep(userName: ''));
    });

    blocTest<OnBoardingBloc, OnBoardingState>(
      'Test Name Submission event',
      build: () {
        return onBoardingBloc;
      },
      act: (bloc) => bloc.add(NameSubmitted('John Doe')),
      expect: () => [
        const CategoriesStep(userFavCategories: []),
      ],
    );

    blocTest<OnBoardingBloc, OnBoardingState>(
      'Test Add user category event',
      build: () => onBoardingBloc,
      act: (bloc) {
        bloc.add(CategoriesUpdate('Sports'));
      },
      expect: () => [
        const CategoriesStep(userFavCategories: ['Sports']),
      ],
    );

    blocTest<OnBoardingBloc, OnBoardingState>(
      'Test category Submission event',
      build: () => onBoardingBloc,
      act: (bloc) {
        bloc.add(CategoriesSubmitted(const ['Sports', 'Politics']));
      },
      expect: () => [
        const CityStep(userCityName: null),
      ],
    );

    blocTest<OnBoardingBloc, OnBoardingState>(
      'Test Autofill location Success event',
      build: () {
        when(() => mockLocationService.getCurrentPosition())
            .thenAnswer((_) async => mockPosition);
        when(() => mockLocationService.fetchUserLocation(10.0, 20.0))
            .thenAnswer((_) async => mockUserLocationData);
        when(() => mockLocationService.getCurrentPosition())
            .thenThrow(Exception('Location service error'));
        return onBoardingBloc;
      },
      act: (bloc) async {
        bloc.add(CityAutoFilled());
      },
      expect: () => [
        const CityStep(),
      ],
    );

    blocTest<OnBoardingBloc, OnBoardingState>(
      'test Autofill location failed event',
      build: () {
        when(() => mockLocationService.getCurrentPosition())
            .thenThrow(Exception('Location service error'));

        return onBoardingBloc;
      },
      act: (bloc) async {
        bloc.add(CityAutoFilled());
      },
      expect: () => [
        const CityStep(userCityName: null),
      ],
    );

    blocTest<OnBoardingBloc, OnBoardingState>(
      'Test back pressed from CategoriesStep',
      build: () {
        onBoardingBloc.emit(const CategoriesStep(userFavCategories: []));
        return onBoardingBloc;
      },
      act: (bloc) => bloc.add(BackPressed()),
      expect: () => [
        const NameStep(userName: ''),
      ],
    );

    blocTest<OnBoardingBloc, OnBoardingState>(
      'Test back pressed from CityStep',
      build: () {
        onBoardingBloc.emit(const CityStep(userCityName: null));
        return onBoardingBloc;
      },
      act: (bloc) => bloc.add(BackPressed()),
      expect: () => [
        CategoriesStep(userFavCategories: mockUser.favNewsCategory),
      ],
    );
  });
}
