part of 'fav_news_bloc.dart';

sealed class FavNewsState extends Equatable {
  const FavNewsState();

  @override
  List<Object> get props => [];
}

class FavNewsLoadingState extends FavNewsState {}

class FavNewsLoadedState extends FavNewsState {
  final News userNews;
  const FavNewsLoadedState({
    required this.userNews,
  });
}

class FavNewsErrorState extends FavNewsState {
  final String errorMessage;
  const FavNewsErrorState({
    required this.errorMessage,
  });
}
