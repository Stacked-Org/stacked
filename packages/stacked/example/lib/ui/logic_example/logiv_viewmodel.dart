import 'package:new_architecture/app/app.locator.dart';
import 'package:new_architecture/app/app.logic.dart';
import 'package:new_architecture/datamodels/human.dart';
import 'package:new_architecture/logic/action_descriptions.dart';
import 'package:stacked/stacked.dart';

class LogicViewModel extends BaseViewModel {
  final _logicRunner = locator<LogicRunner>();
  List<Human> humans = [];

  Future getInfo() async {
    humans = await runBusyFuture(
      _logicRunner.runLogicAction(GetAllHumansActionDescription()),
    );
    notifyListeners();
  }
}
