import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/common/constants/app_constants.dart';
import 'package:vista_news/common/widgets/common_app_button.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';
import 'package:vista_news/utils/util_services.dart';

class CategoriesStepWidget extends StatelessWidget {
  final List<String> userSelectedCategory;

  const CategoriesStepWidget({super.key, required this.userSelectedCategory});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Step 2: Select your favorite categories",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 30,
              ),
              Wrap(
                spacing: 10,
                children: availableCategories.map((category) {
                  return ChoiceChip(
                    label: Text(category),
                    selected: userSelectedCategory.contains(category),
                    onSelected: (isSelected) {
                      context
                          .read<OnBoardingBloc>()
                          .add(CategoriesUpdate(category));
                    },
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonAppButton(
                    buttonAction: () {
                      BlocProvider.of<OnBoardingBloc>(context)
                          .add(BackPressed());
                    },
                    buttonName: "Back",
                  ),
                  CommonAppButton(
                    buttonAction: () {
                      if (userSelectedCategory.length < 2) {
                        UtilServices.showToast(
                            message: "Please select minimum 2 category");
                      } else if (userSelectedCategory.length > 4) {
                        UtilServices.showToast(
                            message: "You can select 4 category max");
                      } else {
                        context
                            .read<OnBoardingBloc>()
                            .add(CategoriesSubmitted(userSelectedCategory));
                      }
                    },
                    buttonName: "Next",
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
