import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks_example/ui/common/app_colors.dart';
import 'package:stacked_hooks_example/ui/common/ui_helpers.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel model, Widget? child) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                verticalSpaceLarge,
                Column(
                  children: const [
                    Text(
                      'Stacked Hooks Example',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    verticalSpaceMedium,
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'With Stacked Hook',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: model.goToWithStackedHook,
                    ),
                    MaterialButton(
                      color: kcDarkGreyColor,
                      child: const Text(
                        'Without Stacked Hook',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: model.goToWithoutStackedHook,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  HomeViewModel modelBuilder(BuildContext context) {
    return HomeViewModel();
  }
}
