import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/repositories/news_repository.dart';

part 'all_news_event.dart';
part 'all_news_state.dart';

class AllNewsBloc extends Bloc<AllNewsEvent, AllNewsState> {
  final NewsRepository _newsRepository;
  AllNewsBloc(this._newsRepository) : super(AllNewsLoadingState()) {
    on<FetchAllNews>(_onFetchAllNewsEvent);
  }

  _onFetchAllNewsEvent(FetchAllNews event, Emitter<AllNewsState> emit) async {
    emit(AllNewsLoadingState());
    try {
      final newsData = await _newsRepository.fetchAllNews();
      emit(AllNewsLoadedState(userNews: newsData));
    } catch (e) {
      emit(AllNewsErrorState(errorMessage: e.toString()));
    }
  }
}
