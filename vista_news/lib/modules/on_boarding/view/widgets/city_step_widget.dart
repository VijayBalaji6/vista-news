import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/common/widgets/common_app_button.dart';
import 'package:vista_news/common/widgets/common_text_from_field.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';

class CityStepWidget extends StatelessWidget {
  final TextEditingController cityController = TextEditingController();

  CityStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
      builder: (context, state) {
        String cityName = "";
        if (state is CityStep) {
          cityName = state.userCityName ?? "";
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Step 3: Enter your city",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              CommonTextFormField(
                textFormFieldController: cityController..text = cityName,
                labelName: "City",
                prefixIcon: Icons.location_city_outlined,
                emptyMessage: 'Please enter your name',
                validationMessage: 'Only alphabets allowed',
                textFieldValidateExpression: r'^[a-zA-Z]+$',
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: CommonAppButton(
                      buttonAction: () {
                        context.read<OnBoardingBloc>().add(BackPressed());
                      },
                      buttonName: "Back",
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: CommonAppButton(
                      buttonAction: () {
                        context.read<OnBoardingBloc>().add(CitySubmitted(
                            cityController.text.isEmpty
                                ? null
                                : cityController.text));
                      },
                      buttonName: "Finish",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CommonAppButton(
                buttonAction: () {
                  context.read<OnBoardingBloc>().add(CityAutoFilled());
                },
                buttonName: " Auto-fill city ",
              )
            ],
          ),
        );
      },
    );
  }
}
