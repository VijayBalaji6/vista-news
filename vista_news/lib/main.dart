import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vista_news/modules/home/bloc/home_bloc.dart';
import 'package:vista_news/modules/news/all_news/bloc/all_news_bloc.dart';
import 'package:vista_news/modules/news/fav_news/bloc/fav_news_bloc.dart';
import 'package:vista_news/modules/news/saved_news/bloc/saved_news_bloc.dart';
import 'package:vista_news/modules/settings/bloc/settings_bloc.dart';
import 'package:vista_news/modules/splash/bloc/splash_bloc.dart';
import 'package:vista_news/services/local/news_db_services.dart';
import 'package:vista_news/services/networking/chopper_client.dart';
import 'package:vista_news/utils/routes/app_routes.dart';
import 'package:vista_news/utils/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Chopper clients
  ChopperClientInstance.initializeNewsClient();
  ChopperClientInstance.initializeWeatherClient();
  ChopperClientInstance.initializeLocationClient();

  final newsDbService = NewsDbService();
  await newsDbService.init();

  // setting application to portrait
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsBloc>(
            create: (BuildContext context) => SettingsBloc()),
        BlocProvider<SplashBloc>(
            create: (BuildContext context) => SplashBloc()),
        BlocProvider<HomeBloc>(create: (BuildContext context) => HomeBloc()),
        BlocProvider<AllNewsBloc>(
            create: (BuildContext context) => AllNewsBloc()),
        BlocProvider<FavNewsBloc>(
            create: (BuildContext context) => FavNewsBloc()),
        BlocProvider<SavedNewsBloc>(
            create: (BuildContext context) => SavedNewsBloc()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRoutes.appRoutes,
              title: 'Flutter Demo',
              themeMode: state.themeData == AppTheme.lightThemeData
                  ? ThemeMode.light
                  : ThemeMode.dark,
              theme: AppTheme.lightThemeData,
              darkTheme: AppTheme.darkThemeData,
            );
          },
        ),
      ),
    );
  }
}
