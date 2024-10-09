import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vista_news/modules/splash/bloc/splash_bloc.dart';
import 'package:vista_news/services/networking/chopper_client.dart';
import 'package:vista_news/utils/routes/app_routes.dart';
import 'package:vista_news/utils/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Chopper clients
  ChopperClientInstance.initializeNewsClient();
  ChopperClientInstance.initializeWeatherClient();
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
        BlocProvider<SplashBloc>(
            create: (BuildContext context) =>
                SplashBloc()..add(CheckIsUserRegisteredEvent())),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: false,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoutes.appRoutes,
          title: 'Flutter Demo',
          themeMode: ThemeMode.light,
          theme: AppTheme.lightThemeData,
          darkTheme: AppTheme.darkThemeData,
        ),
      ),
    );
  }
}
