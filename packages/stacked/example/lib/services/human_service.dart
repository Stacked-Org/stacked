import 'package:new_architecture/datamodels/human.dart';

class HumanService {
  /// Returns a list of 20 humans with weird names
  Future<List<Human>> getHumans() async {
    await Future.delayed(Duration(seconds: 2));
    return List<Human>.generate(
      20,
      (index) => Human(
        name: 'Name $index',
        surname: 'Surname $index',
      ),
    );
  }
}
