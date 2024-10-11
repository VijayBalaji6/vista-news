// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'on_boarding_bloc.dart';

sealed class OnBoardingState extends Equatable {
  const OnBoardingState();

  @override
  List<Object> get props => [];
}

class NameStep extends OnBoardingState {
  final String userName;
  const NameStep({required this.userName});

  @override
  List<Object> get props => [userName];
}

class CategoriesStep extends OnBoardingState {
  final List<String> userFavCategories;
  const CategoriesStep({required this.userFavCategories});
  @override
  List<Object> get props => [userFavCategories];
}

class CityStep extends OnBoardingState {
  final String? userCityName;
  const CityStep({required this.userCityName});
  @override
  List<Object> get props => [userCityName ?? ""];
}

class OnBoardingComplete extends OnBoardingState {
  final User user;
  const OnBoardingComplete({
    required this.user,
  });
  @override
  List<Object> get props => [user];
}
