import 'package:new_architecture/app/app.locator.dart';
import 'package:new_architecture/datamodels/human.dart';
import 'package:new_architecture/logic/action_description.dart';
import 'package:new_architecture/logic/logic_action.dart';
import 'package:new_architecture/services/cache_service.dart';
import 'package:new_architecture/services/human_service.dart';

/// Checks in the cache if there are any humans stored. If there's nothing in the cache
/// we get the humans from the human service
class GetAllHumansAction extends LogicAction<List<Human>> {
  final _humanService = locator<HumanService>();
  final _cachedService = locator<CacheService>();

  @override
  Future<List<Human>> run() async {
    List<Human> humanToReturn = _cachedService.getCachedHumans();

    if (humanToReturn.isEmpty) {
      humanToReturn = await _humanService.getHumans();
    }

    return humanToReturn;
  }
}
