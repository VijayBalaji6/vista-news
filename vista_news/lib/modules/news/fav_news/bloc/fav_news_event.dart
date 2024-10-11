part of 'fav_news_bloc.dart';

sealed class FavNewsEvent extends Equatable {
  const FavNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchFavNews extends FavNewsEvent {}
