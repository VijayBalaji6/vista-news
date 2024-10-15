import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/constants/app_colors.dart';
import 'package:vista_news/models/weather/weather.dart';
import 'package:vista_news/modules/home/view/widgtes/home_weather_info_widget.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar(
      {super.key, required this.weatherData, required this.userName});
  final Weather weatherData;
  final String userName;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.themeColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeWeatherInfoWidget(
                weatherData: weatherData,
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: AppColors.whiteColor,
                ),
                onPressed: () {
                  context.pushNamed(AppRouteConstants.settingsScreen);
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
