import 'package:new_architecture/app/locator.dart';
import 'package:new_architecture/services/epoch_service.dart';
import 'package:stacked/stacked.dart';

class MultiStreamExampleViewModel extends MultiStreamViewModel {
  Map<String, Stream> get streams => {
        "slow_numbers": locator<EpochService>().epochUpdatesNumbers(),
        "fast_numbers": locator<EpochService>().epochUpdateNumbersQuickly()
      };

  int get slowNumber => streamsOut["slow_numbers"].data;
  int get fastNumber => streamsOut["fast_numbers"].data;

  // Transforms data
  void growBigger(int factor) {
    streamsOut["fast_numbers"].transformData((int dataIn) {
      dataIn = dataIn + factor;
    });
  }
}
