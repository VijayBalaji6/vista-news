import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/modules/splash/bloc/splash_bloc.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(CheckIsUserRegisteredEvent()),
      child: Scaffold(
        body: Center(
          child: BlocListener<SplashBloc, SplashState>(
            listener: (BuildContext context, state) {
              if (state is RegisteredState) {
                context.goNamed(AppRouteConstants.homeScreen);
              } else if (state is UnRegisteredState) {
                context.goNamed(AppRouteConstants.onBoardingScreen);
              }
            },
            child: SizedBox(
              height: 200.sp,
              width: 200.sp,
              child: const Text("Splash Screen"),
              //child: Image.asset("assets/app_logo/todo_app_logo.png")
            ),
          ),
        ),
      ),
    );
  }
}
