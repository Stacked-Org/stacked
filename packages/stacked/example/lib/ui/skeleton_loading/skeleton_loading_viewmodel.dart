import 'package:stacked/stacked.dart';

class ListItem {
  final String title;
  final String description;

  ListItem({required this.title, required this.description});

  @override
  String toString() {
    return '$title - $description';
  }
}

class SkeletonLoadingViewModel extends FutureViewModel<List<ListItem>> {
  List<ListItem> get listData => skeletonData(
        realData: data,
        busyData: List<ListItem>.generate(
          2,
          (index) => ListItem(
            description: 'This is a description'.substring(index),
            title: 'This is a tile',
          ),
        ),
      );

  @override
  Future<List<ListItem>> futureToRun() async {
    await Future.delayed(Duration(seconds: 5));
    return List<ListItem>.generate(
        10,
        (index) => ListItem(
            description: 'This is a description'.substring(index),
            title: 'This is a tile'));
  }
}
