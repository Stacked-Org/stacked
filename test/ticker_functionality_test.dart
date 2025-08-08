import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stacked/stacked.dart';

class TestTickerViewModel extends BaseViewModel with StackedSingleTickerProviderStateMixin {
  late TabController tabController;

  initialise() {
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

void main() {
  group('StackedSingleTickerProviderStateMixin', () {
    test('When tabController is initialised, it should not be null', () {
      final viewModel = TestTickerViewModel();
      viewModel.initialise();
      expect(viewModel.tabController, isNotNull);
    });
    test('When tabController is disposed, it should be null', () {
      final viewModel = TestTickerViewModel();
      viewModel.initialise();
      viewModel.dispose();
      expect(viewModel.tabController.animation, isNull);
    });

  
  });
}
