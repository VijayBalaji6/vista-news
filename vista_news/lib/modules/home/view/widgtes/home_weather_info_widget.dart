import 'package:flutter/material.dart';
import 'package:vista_news/common/constants/app_colors.dart';
import 'package:vista_news/models/weather_model.dart';

class HomeWeatherInfoWidget extends StatelessWidget {
  const HomeWeatherInfoWidget({super.key, required this.weatherData});
  final Weather weatherData;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weather in ${weatherData.current!.condition!.text}',
          style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor),
        ),
        Text(
          'Weather in ${weatherData.current!.tempC} C', // Replace with actual weather data
          style: const TextStyle(fontSize: 18, color: AppColors.whiteColor),
        ),
      ],
    );
  }
}
