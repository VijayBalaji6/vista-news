import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/constants/app_colors.dart';
import 'package:vista_news/modules/home/bloc/home_bloc.dart';
import 'package:vista_news/modules/home/view/home_bottom_bar.dart';
import 'package:vista_news/modules/home/view/home_page_body.dart';
import 'package:vista_news/modules/home/view/widgtes/home_weather_info_widget.dart';
import 'package:vista_news/modules/settings/bloc/settings_bloc.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';
import 'package:vista_news/utils/util_services.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final settingsState = state;
        return BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            final homeState = state;
            if (state is WeatherLoadingState) {
              context
                  .read<HomeBloc>()
                  .add(LoadWeatherEvent(cityName: settingsState.user!.city!));
            }
            return Scaffold(
                body: SafeArea(
                  child: Column(
                    children: [
                      Container(
                        color: AppColors.themeColor,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Text(
                              UtilServices.getGreetingMessage(),
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              settingsState.user?.userName ?? 'User',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.whiteColor),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                (settingsState.user != null ||
                                        settingsState.user?.city != null ||
                                        settingsState.user!.city!.isEmpty)
                                    ? (homeState is WeatherLoadingState)
                                        ? const CircularProgressIndicator()
                                        : (homeState is WeatherErrorState)
                                            ? Container()
                                            : HomeWeatherInfoWidget(
                                                weatherData:
                                                    homeState.weatherData!,
                                              )
                                    : Container(),
                                IconButton(
                                  icon: const Icon(
                                    Icons.settings,
                                    color: AppColors.whiteColor,
                                  ),
                                  onPressed: () {
                                    context.pushNamed(
                                        AppRouteConstants.settingsScreen);
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: HomePageBody(
                              currentPage: homeState.currentTabIndex)),
                    ],
                  ),
                ),
                bottomNavigationBar: HomePageBottomBar(
                  currentPage: homeState.currentTabIndex,
                ));
          },
        );
      },
    );
  }
}
