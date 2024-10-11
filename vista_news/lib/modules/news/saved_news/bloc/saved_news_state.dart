part of 'saved_news_bloc.dart';

sealed class SavedNewsState extends Equatable {
  const SavedNewsState();

  @override
  List<Object> get props => [];
}

class SavedNewsLoadingState extends SavedNewsState {}

class SavedNewsLoadedState extends SavedNewsState {
  final List<Articles> newsArticles;
  const SavedNewsLoadedState({
    required this.newsArticles,
  });
}

class SavedNewsErrorState extends SavedNewsState {
  final String errorMessage;
  const SavedNewsErrorState({
    required this.errorMessage,
  });
}
