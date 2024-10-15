import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/modules/news/all_news/bloc/all_news_bloc.dart';
import 'package:vista_news/modules/news/fav_news/bloc/fav_news_bloc.dart';
import 'package:vista_news/modules/news/saved_news/bloc/saved_news_bloc.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';
import 'package:vista_news/modules/on_boarding/view/widgets/category_step_widget.dart';
import 'package:vista_news/modules/on_boarding/view/widgets/city_step_widget.dart';
import 'package:vista_news/modules/on_boarding/view/widgets/name_step_widget.dart';
import 'package:vista_news/modules/settings/bloc/settings_bloc.dart';
import 'package:vista_news/repositories/auth_repository.dart';
import 'package:vista_news/repositories/location_repository.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final LocationRepository locationRepository = LocationRepositoryImpl();
  final AuthRepository authRepository = AuthRepositoryImpl();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnBoardingBloc(
          locationRepository: locationRepository,
          authRepository: authRepository),
      child: Scaffold(
        appBar: AppBar(title: const Text("Onboarding Flow")),
        body: BlocConsumer<OnBoardingBloc, OnBoardingState>(
          listener: (context, state) {
            if (state is OnBoardingComplete) {
              context.goNamed(AppRouteConstants.homeScreen);
              context
                  .read<SettingsBloc>()
                  .add(UpdateUserDataEvent(userData: state.user));

              context.read<AllNewsBloc>().add(FetchAllNews());
              context.read<FavNewsBloc>().add(FetchFavNews());
              context.read<SavedNewsBloc>().add(FetchSavedNews());
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
