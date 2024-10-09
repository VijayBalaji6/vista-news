part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  final int? currentTabIndex;
  final Weather? weatherData;
  final String? weatherErrorMessage;

  const HomeState({
    this.currentTabIndex,
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

final class CurrentBottomNavState extends HomeState {
  const CurrentBottomNavState({required int currentTabIndex})
      : super(currentTabIndex: currentTabIndex);

  @override
  List<Object?> get props => [currentTabIndex];
}

final class WeatherLoadedState extends HomeState {
  const WeatherLoadedState({
    required Weather weatherData,
  }) : super(weatherData: weatherData);
}

final class WeatherLoadingState extends HomeState {
  const WeatherLoadingState();
}

final class WeatherErrorState extends HomeState {
  const WeatherErrorState({
    required String weatherErrorMessage,
  }) : super(weatherErrorMessage: weatherErrorMessage);
}
