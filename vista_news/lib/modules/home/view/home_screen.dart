import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/modules/home/bloc/home_bloc.dart';
import 'package:vista_news/modules/home/view/home_bottom_bar.dart';
import 'package:vista_news/modules/home/view/home_page_body.dart';
import 'package:vista_news/modules/home/view/widgtes/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(const LoadWeatherEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return Scaffold(
              floatingActionButton: FloatingActionButton(
                  onPressed: () =>
                      context.read<HomeBloc>().add(const LoadWeatherEvent())),
              body: SafeArea(
                child: Column(
                  children: [
                    if (state is WeatherLoadedState)
                      HomeAppBar(
                        weatherData: state.weatherData!,
                      ),
                    if (state is WeatherLoadingState)
                      const CircularProgressIndicator(),
                    if (state is WeatherErrorState)
                      Text(state.weatherErrorMessage ?? ""),
                    Expanded(
                        child: HomePageBody(
                            currentPage: state.currentTabIndex ?? 0)),
                  ],
                ),
              ),
              bottomNavigationBar: HomePageBottomBar(
                currentPage: state.currentTabIndex ?? 0,
              ));
        },
      ),
    );
  }
}
