part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabEvent extends HomeEvent {
  final int tabIndex;

  const ChangeTabEvent({required this.tabIndex,});

  @override
  List<Object> get props => [tabIndex];
}

class LoadWeatherEvent extends HomeEvent {
  const LoadWeatherEvent({required this.cityName});
  final String cityName;
  @override
  List<Object> get props => [cityName];
}
