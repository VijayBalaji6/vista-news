import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';

class CityStepWidget extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  CityStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Step 3: Enter your city"),
          TextFormField(
            controller: cityController,
            decoration: const InputDecoration(hintText: "City"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.read<OnBoardingBloc>().add(BackPressed());
                },
                child: const Text("Back"),
              ),
              ElevatedButton(
                onPressed: () {
                  context
                      .read<OnBoardingBloc>()
                      .add(CitySubmitted(cityController.text));
                },
                child: const Text("Finish"),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<OnBoardingBloc>().add(CityAutoFilled());
                },
                child: const Text("Auto-fill city"),
              )
            ],
          )
        ],
      ),
    );
  }
}
