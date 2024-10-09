import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';
import 'package:vista_news/modules/on_boarding/view/widgets/category_step_widget.dart';
import 'package:vista_news/modules/on_boarding/view/widgets/city_step_widget.dart';
import 'package:vista_news/modules/on_boarding/view/widgets/name_step_widget.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Onboarding Flow")),
        body: BlocConsumer<OnBoardingBloc, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingComplete) {
              context.goNamed(AppRouteConstants.homeScreen);
            }
          },
          builder: (context, state) {
            if (state is NameStep) {
              return NameStepWidget(userName: state.userName);
            } else if (state is CategoriesStep) {
              return CategoriesStepWidget(
                userSelectedCategory: state.userFavCategories,
              );
            } else if (state is CityStep) {
              return CityStepWidget();
            }
            return Container();
          },
        ),
      ),
    );
  }
}
