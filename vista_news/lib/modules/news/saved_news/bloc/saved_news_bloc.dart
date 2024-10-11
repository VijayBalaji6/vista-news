import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/services/local/news_db_services.dart';

part 'saved_news_event.dart';
part 'saved_news_state.dart';

class SavedNewsBloc extends Bloc<SavedNewsEvent, SavedNewsState> {
  SavedNewsBloc() : super(SavedNewsLoadingState()) {
    on<FetchSavedNews>(_onFetchSavedNewsEvent);
  }

  _onFetchSavedNewsEvent(
      FetchSavedNews event, Emitter<SavedNewsState> emit) async {
    emit(SavedNewsLoadingState());
    try {
      final newsData = await NewsDbService().getAllSavedNews();
      emit(SavedNewsLoadedState(newsArticles: newsData));
    } catch (e) {
      emit(SavedNewsErrorState(errorMessage: e.toString()));
    }
  }
}
