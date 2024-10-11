import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/location/location.dart';
import 'package:vista_news/models/user/user.dart';
import 'package:vista_news/repositories/auth_repository.dart';
import 'package:vista_news/services/local/auth_services.dart';
import 'package:vista_news/services/remote/location_services.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  User user = User(
    userName: '',
    favNewsCategory: [],
    city: null,
  );

  final AuthRepository _authRepository = AuthRepository(AuthService());

  OnBoardingBloc() : super(const NameStep(userName: '')) {
    on<NameSubmitted>(_onNameSubmitted);

    on<CategoriesUpdate>(_onCategoriesUpdate);

    on<CategoriesSubmitted>(_onCategoriesSubmitted);

    on<CitySubmitted>(_onCitySubmitted);

    on<CityAutoFilled>(_onCityAutoFilled);

    on<BackPressed>(_onBackPressed);
  }

  _onNameSubmitted(NameSubmitted event, Emitter<OnBoardingState> emit) {
    user = user.copyWith(userName: event.name);
    emit(CategoriesStep(userFavCategories: user.favNewsCategory));
  }

  _onCategoriesUpdate(CategoriesUpdate event, Emitter<OnBoardingState> emit) {
    List<String> updatedFavCategories = List<String>.from(user.favNewsCategory);
    if (updatedFavCategories.contains(event.selectedCategory)) {
      updatedFavCategories.remove(event.selectedCategory);
    } else {
      if (updatedFavCategories.length < 4) {
        updatedFavCategories.add(event.selectedCategory);
      }
    }
    user = user.copyWith(favNewsCategory: updatedFavCategories);

    emit(CategoriesStep(
        userFavCategories: List<String>.from(updatedFavCategories)));
  }

  _onCategoriesSubmitted(
      CategoriesSubmitted event, Emitter<OnBoardingState> emit) {
    user = user.copyWith(favNewsCategory: event.selectedCategories);
    emit(CityStep(userCityName: user.city));
  }

  _onCitySubmitted(CitySubmitted event, Emitter<OnBoardingState> emit) {
    user = user.copyWith(city: event.city);
    _authRepository.logInUser(userData: user);
    emit(OnBoardingComplete(user: user));
  }

  _onCityAutoFilled(CityAutoFilled event, Emitter<OnBoardingState> emit) async {
    try {
      final userLocation = await LocationService.getCurrentPosition();
      final Location userLocationData = await LocationService.getUserLocation(
          latitude: userLocation.latitude, longitude: userLocation.longitude);
      emit(CityStep(userCityName: userLocationData.city));
    } catch (e) {
      emit(const CityStep(userCityName: null));
    }
  }

  _onBackPressed(BackPressed event, Emitter<OnBoardingState> emit) {
    if (state is CityStep) {
      emit(CategoriesStep(userFavCategories: user.favNewsCategory));
    } else if (state is CategoriesStep) {
      emit(NameStep(userName: user.userName));
    }
  }
}
