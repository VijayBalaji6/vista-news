import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vista_news/common/widgets/common_app_button.dart';
import 'package:vista_news/common/widgets/common_text_from_field.dart';
import 'package:vista_news/modules/on_boarding/bloc/on_boarding_bloc.dart';

class NameStepWidget extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final nameFormKey = GlobalKey<FormState>();
  final String userName;
  NameStepWidget({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Form(
        key: nameFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Step 1: Enter your name",
              style: TextStyle(fontSize: 30),
            ),
            const SizedBox(
              height: 30,
            ),
            CommonTextFormField(
              textFormFieldController: nameController..text = userName,
              labelName: "Name",
              prefixIcon: Icons.person,
              emptyMessage: 'Please enter your name',
              validationMessage: 'Only alphabets allowed',
              textFieldValidateExpression: r'^[a-zA-Z]+$',
            ),
            const SizedBox(
              height: 30,
            ),
            CommonAppButton(
              buttonAction: () {
                if (nameFormKey.currentState!.validate()) {
                  context
                      .read<OnBoardingBloc>()
                      .add(NameSubmitted(nameController.text));
                }
              },
              buttonName: "Next",
            )
          ],
        ),
      ),
    );
  }
}
