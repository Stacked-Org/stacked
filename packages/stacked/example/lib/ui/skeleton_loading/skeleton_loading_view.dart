import 'package:flutter/material.dart';
import 'package:new_architecture/ui/skeleton_loading/skeleton_loading_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SkeletonLoadingView extends StatelessWidget {
  const SkeletonLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SkeletonLoadingViewModel>.reactive(
      builder: (context, model, child) {
        print(model.listData);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: model.initialise,
          ),
          body: Center(
              child: SkeletonLoader(
            loading: true,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.red,
              height: 50,
            ),
          )),
        );
      },
      viewModelBuilder: () => SkeletonLoadingViewModel(),
    );
  }
}
