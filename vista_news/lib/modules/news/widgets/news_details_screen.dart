import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/constants/app_colors.dart';
import 'package:vista_news/common/widgets/custom_network_image.dart';
import 'package:vista_news/common/widgets/url_launcher.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/news/saved_news/bloc/saved_news_bloc.dart';
import 'package:vista_news/services/local/news_db_services.dart';
import 'package:vista_news/utils/util_services.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen(
      {super.key, required this.newsArticle, this.isSavedArticle = false});
  final Articles newsArticle;
  final bool isSavedArticle;

  final String placeHolderImage =
      "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                newsArticle.title ?? "",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    newsArticle.publishedAt ?? "",
                    style: const TextStyle(color: AppColors.greyColor),
                  ),
                  isSavedArticle
                      ? IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            NewsDbService().deleteSavedNews(newsArticle.id);
                            context.read<SavedNewsBloc>().add(FetchSavedNews());
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            UtilServices.shareData(
                                content: newsArticle.url ?? "News");
                          },
                        ),
                ],
              ),
              const SizedBox(height: 16),

              CustomNetworkImage(
                imageUrl: newsArticle.urlToImage,
              ),

              const SizedBox(height: 16),

              // Description
              Text(
                newsArticle.description ?? "",
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),

              // Open in Browser Button
              if (newsArticle.url != null)
                Center(
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text('Read Full News'),
                    onPressed: () async => await CommonServices.openWebPage(
                        Uri.parse(newsArticle.url!)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  const NewsCard({
    super.key,
    required this.currentNews,
  });

  final Articles currentNews;
  final String placeHolderImage =
      "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => CommonServices.openWebPage(Uri.parse(currentNews.url ?? "")),
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              currentNews.urlToImage ?? placeHolderImage,
              height: 150,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentNews.title ?? "",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currentNews.description ?? "",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
