part of 'on_boarding_bloc.dart';

abstract class OnBoardingEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class NameSubmitted extends OnBoardingEvent {
  final String name;

  NameSubmitted(this.name);

  @override
  List<Object?> get props => [name];
}

class CategoriesSubmitted extends OnBoardingEvent {
  final List<String> selectedCategories;

  CategoriesSubmitted(this.selectedCategories);

  @override
  List<Object?> get props => [selectedCategories];
}

class CategoriesUpdate extends OnBoardingEvent {
  final String selectedCategory;

  CategoriesUpdate(this.selectedCategory);

  @override
  List<Object?> get props => [selectedCategory];
}

class CitySubmitted extends OnBoardingEvent {
  final String? city;

  CitySubmitted(this.city);

  @override
  List<Object?> get props => [city];
}

class CityAutoFilled extends OnBoardingEvent {}

class BackPressed extends OnBoardingEvent {}
