import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/weather/weather.dart';
import 'package:vista_news/repositories/weather_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final WeatherRepository weatherRepository;

  HomeBloc(this.weatherRepository)
      : super(const WeatherLoadingState(currentTabIndex: 1)) {
    on<ChangeTabEvent>(_onChangTabEvent);
    on<LoadWeatherEvent>(_onLoadWeatherEvent);
  }

  void _onChangTabEvent(ChangeTabEvent event, Emitter<HomeState> emit) {
    final currentState = state;
    if (currentState is WeatherLoadedState) {
      emit(WeatherLoadedState(
        weatherData: currentState.weatherData!,
        currentTabIndex: event.tabIndex,
      ));
    } else if (currentState is WeatherErrorState) {
      emit(WeatherErrorState(
        weatherErrorMessage: currentState.weatherErrorMessage!,
        currentTabIndex: event.tabIndex,
      ));
    } else {
      emit(WeatherLoadingState(
        currentTabIndex: event.tabIndex,
      ));
    }
  }

  Future<void> _onLoadWeatherEvent(
      LoadWeatherEvent event, Emitter<HomeState> emit) async {
    final currentTabIndex = state.currentTabIndex;
    emit(WeatherLoadingState(currentTabIndex: currentTabIndex));
    try {
      final weatherApiData = await weatherRepository.getWeather(event.cityName);
      final state = WeatherLoadedState(
        weatherData: weatherApiData,
        currentTabIndex: currentTabIndex,
      );
      emit(state);
    } catch (e) {
      emit(WeatherErrorState(
        weatherErrorMessage: e.toString(),
        currentTabIndex: currentTabIndex,
      ));
    }
  }
}
