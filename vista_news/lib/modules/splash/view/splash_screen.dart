import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/modules/home/bloc/home_bloc.dart';
import 'package:vista_news/modules/news/all_news/bloc/all_news_bloc.dart';
import 'package:vista_news/modules/news/fav_news/bloc/fav_news_bloc.dart';
import 'package:vista_news/modules/news/saved_news/bloc/saved_news_bloc.dart';
import 'package:vista_news/modules/settings/bloc/settings_bloc.dart';
import 'package:vista_news/modules/splash/bloc/splash_bloc.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';
import 'package:vista_news/utils/util_services.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<SplashBloc, SplashState>(
          listener: (BuildContext context, state) {
            if (state is RegisteredState) {
              UtilServices.hasNetworkConnection().then((hasNetwork) {
                if (context.mounted) {
                  context
                      .read<HomeBloc>()
                      .add(ChangeTabEvent(tabIndex: hasNetwork ? 1 : 2));
                  context.goNamed(AppRouteConstants.homeScreen);
                }
              });

              context
                  .read<SettingsBloc>()
                  .add(UpdateUserDataEvent(userData: state.registerUserData));

              context.read<AllNewsBloc>().add(FetchAllNews());
              context.read<FavNewsBloc>().add(FetchFavNews());
              context.read<SavedNewsBloc>().add(FetchSavedNews());
            } else if (state is UnRegisteredState) {
              context.goNamed(AppRouteConstants.onBoardingScreen);
            }
          },
          child: SizedBox(
              height: 200.sp,
              width: 200.sp,
              child: Image.asset("assets/splash_image.png")),
        ),
      ),
    );
  }
}
