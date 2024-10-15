import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vista_news/models/weather/weather.dart';
import 'package:vista_news/modules/home/bloc/home_bloc.dart';
import 'package:vista_news/repositories/weather_repository.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class FakeWeatherModel extends Fake implements Weather {}

void main() {
  group('HomeBloc', () {
    late HomeBloc homeBloc;
    late MockWeatherRepository mockWeatherRepository;

    setUpAll(() {
      registerFallbackValue(FakeWeatherModel());
    });

    setUp(() {
      mockWeatherRepository = MockWeatherRepository();
      homeBloc = HomeBloc(mockWeatherRepository);
    });

    tearDown(() {
      homeBloc.close();
    });

    blocTest<HomeBloc, HomeState>(
      'Test LoadWeatherEvent success case',
      build: () {
        when(() => mockWeatherRepository.getWeather('New York')).thenAnswer(
          (_) async => const Weather(),
        );
        return homeBloc;
      },
      act: (bloc) => bloc.add(const LoadWeatherEvent(cityName: 'New York')),
      expect: () => [
        const WeatherLoadingState(currentTabIndex: 1),
        const WeatherLoadedState(
          weatherData: Weather(),
          currentTabIndex: 1,
        ),
      ],
      verify: (_) {
        // Verifies that the repository's getWeather function was called once
        verify(() => mockWeatherRepository.getWeather('New York')).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Test LoadWeatherEvent fails case',
      build: () {
        // Simulate an exception being thrown by the repository
        when(() => mockWeatherRepository.getWeather('New York'))
            .thenThrow(Exception('Failed to load weather data'));
        return homeBloc;
      },
      act: (bloc) => bloc.add(const LoadWeatherEvent(cityName: 'New York')),
      expect: () => [
        const WeatherLoadingState(currentTabIndex: 1),
        const WeatherErrorState(
          weatherErrorMessage: 'Exception: Failed to load weather data',
          currentTabIndex: 1,
        ),
      ],
      verify: (_) {
        verify(() => mockWeatherRepository.getWeather('New York')).called(1);
      },
    );

    blocTest<HomeBloc, HomeState>(
      'Test ChangeTabEvent  case',
      build: () => homeBloc,
      act: (bloc) {
        bloc.emit(const WeatherLoadedState(
            weatherData: Weather(), currentTabIndex: 0));
        bloc.add(const ChangeTabEvent(tabIndex: 1));
      },
      expect: () => [
        const WeatherLoadedState(weatherData: Weather(), currentTabIndex: 0),
        const WeatherLoadedState(weatherData: Weather(), currentTabIndex: 1),
      ],
    );
  });
}
