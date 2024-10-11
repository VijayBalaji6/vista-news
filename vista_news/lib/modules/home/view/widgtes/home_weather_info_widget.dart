import 'package:flutter/material.dart';
import 'package:vista_news/common/constants/app_colors.dart';
import 'package:vista_news/models/weather/weather_model.dart';

class HomeWeatherInfoWidget extends StatelessWidget {
  const HomeWeatherInfoWidget({super.key, required this.weatherData});
  final Weather weatherData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weather is ${weatherData.current!.condition!.text}',
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
        Text(
          '${weatherData.current!.tempC}° C',
          style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
