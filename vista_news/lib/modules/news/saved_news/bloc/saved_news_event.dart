part of 'saved_news_bloc.dart';

sealed class SavedNewsEvent extends Equatable {
  const SavedNewsEvent();

  @override
  List<Object> get props => [];
}


class FetchSavedNews extends SavedNewsEvent {}

class DeleteSavedNews extends SavedNewsEvent {}

