import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/news/saved_news/bloc/saved_news_bloc.dart';
import 'package:vista_news/services/local/news_db_services.dart';

class NewsTile extends StatelessWidget {
  const NewsTile(
      {super.key, required this.currentNews, this.isSavedNewsView = false});
  final Articles currentNews;
  final bool isSavedNewsView;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: ListTile(
        title: Text(
          currentNews.title ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: IconButton(
            icon: isSavedNewsView
                ? const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )
                : const Icon(
                    Icons.bookmark,
                    color: Colors.blue,
                  ),
            onPressed: () {
              isSavedNewsView
                  ? NewsDbService().deleteSavedNews(currentNews.id)
                  : NewsDbService().storeNews(currentNews);
              context.read<SavedNewsBloc>().add(FetchSavedNews());
            }),
      ),
    );
  }
}
