part of 'all_news_bloc.dart';

sealed class AllNewsState extends Equatable {
  const AllNewsState();

  @override
  List<Object> get props => [];
}

class AllNewsLoadingState extends AllNewsState {}

class AllNewsLoadedState extends AllNewsState {
  final News userNews;
  const AllNewsLoadedState({
    required this.userNews,
  });
}

class AllNewsErrorState extends AllNewsState {
  final String errorMessage;
  const AllNewsErrorState({
    required this.errorMessage,
  });
}
