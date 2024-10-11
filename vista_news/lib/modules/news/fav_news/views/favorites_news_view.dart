import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/widgets/retry_widget.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/news/fav_news/bloc/fav_news_bloc.dart';
import 'package:vista_news/modules/news/widgets/news_tile.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class FavoritesNewsView extends StatelessWidget {
  const FavoritesNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavNewsBloc, FavNewsState>(builder: (context, state) {
      if (state is FavNewsLoadedState) {
        final List<Articles> favNewsArticles = state.userNews.articles ?? [];
        return RefreshIndicator(
          onRefresh: () async =>
              context.read<FavNewsBloc>().add(FetchFavNews()),
          child: (favNewsArticles.isEmpty)
              ? RetryWidget(
                  message: "No  News",
                  retryAction: () =>
                      context.read<FavNewsBloc>().add(FetchFavNews()),
                )
              : Scrollbar(
                  child: ListView.builder(
                      itemCount: favNewsArticles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              AppRouteConstants.newsDetailScreen,
                              extra: {
                                'article': favNewsArticles[index],
                                'isSavedNews': false,
                              },
                            );
                          },
                          child: NewsTile(
                            currentNews: favNewsArticles[index],
                          ),
                        );
                      }),
                ),
        );
      } else if (state is FavNewsLoadingState) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is FavNewsErrorState) {
        return RetryWidget(
          message: state.errorMessage,
          retryAction: () => context.read<FavNewsBloc>().add(FetchFavNews()),
        );
      } else {
        return Container();
      }
    });
  }
}
