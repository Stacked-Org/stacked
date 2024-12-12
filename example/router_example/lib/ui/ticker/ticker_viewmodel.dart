import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class TickerViewModel extends BaseViewModel with StackedSingleTickerProviderStateMixin {
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
