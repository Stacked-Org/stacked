import 'package:example/datamodels/clashable_two.dart';
import 'package:flutter/material.dart';
import 'package:example/ui/stream_view/stream_counter_viewmodel.dart';
import 'package:stacked/stacked.dart';

class StreamCounterView extends StatelessWidget {
  final List<Clashable> clashableTwo;
  const StreamCounterView({super.key, required this.clashableTwo});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StreamCounterViewModel>.reactive(
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Stream Counter View'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: viewModel.changeStreamSources,
                child: const Text('Change Stream Sources'),
              ),
              const SizedBox(height: 10),
              Text(
                viewModel.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                viewModel.streamSource,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: viewModel.navigateToNewView,
        ),
      ),
      viewModelBuilder: () => StreamCounterViewModel(),
    );
  }
}
