import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/repositories/news_repository.dart';

part 'fav_news_event.dart';
part 'fav_news_state.dart';

class FavNewsBloc extends Bloc<FavNewsEvent, FavNewsState> {
  final NewsRepository _newsRepository;

  FavNewsBloc(this._newsRepository) : super(FavNewsLoadingState()) {
    on<FetchFavNews>(_onFetchFavNewsEvent);
  }

  _onFetchFavNewsEvent(FetchFavNews event, Emitter<FavNewsState> emit) async {
    emit(FavNewsLoadingState());

    try {
      List<String> favCategories = ['sports', 'health'];
      News? allFavNews;

      for (String category in favCategories) {
        final newsData = await _newsRepository.fetchFavNews(category);

        if (allFavNews == null) {
          allFavNews = newsData;
        } else {
          allFavNews = allFavNews.copyWith(
            articles: [...?allFavNews.articles, ...?newsData.articles],
          );
        }
      }

      if (allFavNews != null) {
        emit(FavNewsLoadedState(userNews: allFavNews));
      } else {
        emit(const FavNewsErrorState(errorMessage: 'No news data available'));
      }
    } catch (e) {
      emit(FavNewsErrorState(errorMessage: e.toString()));
    }
  }
}
