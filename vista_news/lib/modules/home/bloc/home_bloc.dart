import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/weather_model.dart';
import 'package:vista_news/services/remote/weather_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const CurrentBottomNavState(currentTabIndex: 0)) {
    on<ChangeTabEvent>(_onChangTabEvent);
    on<LoadWeatherEvent>(_onLoadWeatherEvent);
  }

  void _onChangTabEvent(ChangeTabEvent event, Emitter<HomeState> emit) {
    emit(CurrentBottomNavState(currentTabIndex: event.tabIndex));
  }

  Future<void> _onLoadWeatherEvent(
      LoadWeatherEvent event, Emitter<HomeState> emit) async {
    emit(const WeatherLoadingState());
    try {
      final weatherData = await WeatherServices.getWeather();
      emit(WeatherLoadedState(weatherData: weatherData));
    } catch (e) {
      emit(WeatherErrorState(weatherErrorMessage: e.toString()));
    }
  }
}
