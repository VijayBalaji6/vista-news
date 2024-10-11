import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vista_news/common/constants/app_constants.dart';
import 'package:vista_news/common/widgets/common_app_button.dart';
import 'package:vista_news/common/widgets/common_pop_up.dart';
import 'package:vista_news/common/widgets/common_text_from_field.dart';
import 'package:vista_news/modules/settings/bloc/settings_bloc.dart';
import 'package:vista_news/utils/routes/app_route_constant.dart';

class SettingsScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final List<String> favorites = [
    "News",
    "Sports",
    "Entertainment",
    "Technology"
  ];

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Name Input Field
                showUserData(
                  title: 'Name:',
                  content: state.user?.userName ?? "",
                ),

                const SizedBox(height: 16),
                showUserData(
                  title: 'City:',
                  content: state.user?.city ?? "Not Defined",
                ),

                const SizedBox(height: 20),
                const Text(
                  "Fav News Genre",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 10,
                  children: availableCategories.map((category) {
                    return ChoiceChip(
                      label: Text(category),
                      selected: state.user!.favNewsCategory.contains(category),
                      onSelected: null,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),
                CommonAppButton(
                  buttonAction: () {
                    CommonPopUpMenu.showPopUpDialog(
                        context: context,
                        title: "Edit User Profile",
                        showOk: false,
                        trailingWidgets:
                            BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                const SizedBox(height: 20),
                                CommonTextFormField(
                                  textFormFieldController: nameController
                                    ..text = state.user?.userName ?? "",
                                  labelName: 'Name',
                                  prefixIcon: Icons.person,
                                  emptyMessage: 'Please Enter name',
                                ),
                                const SizedBox(height: 20),
                                CommonTextFormField(
                                  textFormFieldController: cityController
                                    ..text = state.user?.city ?? "",
                                  labelName: 'City',
                                  prefixIcon: Icons.location_city,
                                  emptyMessage: 'Please Enter City',
                                ),
                                const SizedBox(height: 20),
                                CommonAppButton(
                                  buttonAction: () {
                                    context.read<SettingsBloc>().add(
                                        UpdateUserDataEvent(
                                            userData: state.user!.copyWith(
                                                userName: nameController.text,
                                                city: cityController.text)));
                                    context.pop();
                                  },
                                  buttonName: "Update",
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  "Fav News Genre",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 10,
                                  children: availableCategories.map((category) {
                                    final isSelected = state
                                        .user!.favNewsCategory
                                        .contains(category);
                                    return ChoiceChip(
                                      label: Text(category),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        final favCategory =
                                            state.user!.favNewsCategory;
                                        final List<String> updatedCategories;
                                        if (selected) {
                                          if (favCategory.length < 4) {
                                            updatedCategories = [
                                              ...favCategory,
                                              category
                                            ];
                                          } else {
                                            updatedCategories = favCategory;
                                          }
                                        } else {
                                          updatedCategories = favCategory
                                              .where((item) => item != category)
                                              .toList();
                                        }

                                        context.read<SettingsBloc>().add(
                                              UpdateUserDataEvent(
                                                userData: state.user!.copyWith(
                                                    favNewsCategory:
                                                        updatedCategories),
                                              ),
                                            );
                                      },
                                    );
                                  }).toList(),
                                )
                              ],
                            );
                          },
                        ));
                  },
                  buttonName: 'Edit User Profile',
                ),

                const SizedBox(height: 20),

                SwitchListTile(
                  title: const Text("Dark Theme"),
                  value: state.themeData.brightness == Brightness.dark,
                  onChanged: (bool value) {
                    context.read<SettingsBloc>().add(ToggleThemeEvent());
                  },
                ),
                const SizedBox(height: 20),
                CommonAppButton(
                  buttonName: "Logout",
                  buttonAction: () {
                    context.read<SettingsBloc>().add(LogOutUser());
                    context.goNamed(AppRouteConstants.onBoardingScreen);
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Row showUserData({required String title, required String content}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        Text(
          content,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
