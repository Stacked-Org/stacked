import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'ticker_viewmodel.dart';

class TickerView extends StackedView<TickerViewModel> {
  const TickerView({super.key});

  @override
  Widget builder(
    BuildContext context,
    TickerViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ticker View'),
          bottom: TabBar(controller: viewModel.tabController, tabs: const [
            Tab(text: 'Tab 1'),
            Tab(text: 'Tab 2'),
            Tab(text: 'Tab 3'),
          ]),
        ),
        body: TabBarView(
          controller: viewModel.tabController,
          children: const [
            Center(child: Text('Tab 1')),
            Center(child: Text('Tab 2')),
            Center(child: Text('Tab 3')),
          ],
        ));
  }

  @override
  TickerViewModel viewModelBuilder(BuildContext context) => TickerViewModel();

  @override
  void onViewModelReady(TickerViewModel viewModel) {
    viewModel.initialise();
    super.onViewModelReady(viewModel);
  }
}



