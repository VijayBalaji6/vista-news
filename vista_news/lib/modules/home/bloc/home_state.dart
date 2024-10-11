part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final int currentTabIndex;
  final Weather? weatherData;
  final String? weatherErrorMessage;

  const HomeState({
    required this.currentTabIndex,
    this.weatherData,
    this.weatherErrorMessage,
  });

  @override
  List<Object?> get props => [
        currentTabIndex,
        weatherData,
        weatherErrorMessage,
      ];
}

final class WeatherLoadedState extends HomeState {
  const WeatherLoadedState({
    required super.weatherData,
    required super.currentTabIndex,
  });
  @override
  List<Object?> get props => [
        weatherData,
        currentTabIndex,
      ];
}

final class WeatherLoadingState extends HomeState {
  const WeatherLoadingState({required super.currentTabIndex});
  @override
  List<Object?> get props => [
        currentTabIndex,
      ];
}

final class WeatherErrorState extends HomeState {
  const WeatherErrorState({
    required super.weatherErrorMessage,
    required super.currentTabIndex,
  });
  @override
  List<Object?> get props => [
        currentTabIndex,
        weatherErrorMessage,
      ];
}
