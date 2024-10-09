import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';

class CategoriesStepWidget extends StatelessWidget {
  final List<String> availableCategories = [
    'Technology',
    'Business',
    'Health',
    'Sports',
    'Entertainment'
  ];

  final List<String> userSelectedCategory;

  CategoriesStepWidget({super.key, required this.userSelectedCategory});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Step 2: Select your favorite categories"),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<OnBoardingBloc>(context)
                          .add(BackPressed());
                    },
                    child: const Text("Back"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (userSelectedCategory.length >= 2 &&
                          userSelectedCategory.length <= 4) {
                        context
                            .read<OnBoardingBloc>()
                            .add(CategoriesSubmitted(userSelectedCategory));
                      }
                    },
                    child: const Text("Next"),
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
