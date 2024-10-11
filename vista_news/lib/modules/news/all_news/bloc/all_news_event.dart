// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_news_bloc.dart';

sealed class AllNewsEvent extends Equatable {
  const AllNewsEvent();

  @override
  List<Object> get props => [];
}

class FetchAllNews extends AllNewsEvent {}
