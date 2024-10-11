import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/constants/app_colors.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/news/saved_news/bloc/saved_news_bloc.dart';
import 'package:vista_news/modules/news/widgets/news_tile.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class SavedNewsView extends StatelessWidget {
  const SavedNewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavedNewsBloc, SavedNewsState>(
        builder: (context, state) {
      if (state is SavedNewsLoadedState) {
        final List<Articles> savedNewsArticles = state.newsArticles;
        return (savedNewsArticles.isEmpty)
            ? const Center(
                child: Text(
                "No Saved News",
                style: TextStyle(color: AppColors.blackColor),
              ))
            : ListView.builder(
                itemCount: savedNewsArticles.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        AppRouteConstants.newsDetailScreen,
                        extra: {
                          'article': savedNewsArticles[index],
                          'isSavedNews': true,
                        },
                      );
                    },
                    child: NewsTile(
                      isSavedNewsView: true,
                      currentNews: savedNewsArticles[index],
                    ),
                  );
                });
      } else if (state is SavedNewsLoadingState) {
        return const Center(
          child: CircularProgressIndicator.adaptive(),
        );
      } else if (state is SavedNewsErrorState) {
        return Center(
          child: Text(state.errorMessage),
        );
      } else {
        return Container();
      }
    });
  }
}
