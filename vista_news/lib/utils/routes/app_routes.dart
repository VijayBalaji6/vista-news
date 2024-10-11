import 'package:go_router/go_router.dart';
import 'package:vista_news/common/widgets/error_route_screen.dart';
import 'package:vista_news/models/news/news.dart';
import 'package:vista_news/modules/home/view/home_screen.dart';
import 'package:vista_news/modules/news/widgets/news_details_screen.dart';
import 'package:vista_news/modules/on_boarding/view/on_boarding_screen.dart';
import 'package:vista_news/modules/settings/view/settings_screen.dart';
import 'package:vista_news/modules/splash/view/splash_screen.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class AppRoutes {
  static final GoRouter appRoutes = GoRouter(
    initialLocation: '/splash',
    errorBuilder: (context, state) => ErrorRouteScreen(errorState: state),
    routes: [
      GoRoute(
        name: AppRouteConstants.splashScreen,
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.onBoardingScreen,
        path: '/onBoarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.homeScreen,
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.settingsScreen,
        path: '/settings',
        builder: (context, state) => SettingsScreen(),
      ),
      GoRoute(
        name: AppRouteConstants.newsDetailScreen,
        path: '/newsDetail',
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final Articles newsArticle = extra['article'] as Articles;
          final bool isSavedArticle = extra['isSavedNews'] ?? false;
          return NewsDetailScreen(
            newsArticle: newsArticle,
            isSavedArticle: isSavedArticle,
          );
        },
      ),
    ],
  );
}
