import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';

class NameStepWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();

  final String userName;
  NameStepWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Step 1: Enter your name"),
          TextFormField(
            controller: nameController..text = userName,
            decoration: const InputDecoration(hintText: "Name"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                return 'Only alphabets allowed';
              }
              return null;
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text("Back"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty) {
                    context
                        .read<OnBoardingBloc>()
                        .add(NameSubmitted(nameController.text));
                  }
                },
                child: const Text("Next"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
