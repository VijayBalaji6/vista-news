import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/widgets/retry_widget.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/news/all_news/bloc/all_news_bloc.dart';
import 'package:vista_news/modules/news/widgets/news_tile.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class AllNewsView extends StatelessWidget {
  const AllNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllNewsBloc, AllNewsState>(builder: (context, state) {
      if (state is AllNewsLoadedState) {
        final List<Articles> allNewsArticles = state.userNews.articles ?? [];
        return RefreshIndicator(
          onRefresh: () async =>
              context.read<AllNewsBloc>().add(FetchAllNews()),
          child: (allNewsArticles.isEmpty)
              ? RetryWidget(
                  message: "No  News",
                  retryAction: () =>
                      context.read<AllNewsBloc>().add(FetchAllNews()),
                )
              : Scrollbar(
                  child: ListView.builder(
                      itemCount: allNewsArticles.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            context.pushNamed(
                              AppRouteConstants.newsDetailScreen,
                              extra: {
                                'article': allNewsArticles[index],
                                'isSavedNews': false,
                              },
                            );
                          },
                          child: NewsTile(
                            currentNews: allNewsArticles[index],
                          ),
                        );
                      }),
                ),
        );
      } else if (state is AllNewsLoadingState) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is AllNewsErrorState) {
        return RetryWidget(
          message: state.errorMessage,
          retryAction: () => context.read<AllNewsBloc>().add(FetchAllNews()),
        );
      } else {
        return Container();
      }
    });
  }
}
