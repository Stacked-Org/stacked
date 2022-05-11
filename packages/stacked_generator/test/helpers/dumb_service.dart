import 'package:stacked_core/stacked_core.dart';

abstract class AbstractDumpService {}

class DumpService implements AbstractDumpService {
  String? name;
  int? value;
  static DumpService? _instance;

  static DumpService getInstance() {
    if (_instance == null) {
      _instance = DumpService();
    }

    return _instance!;
  }

  static disposee(String) {}
}

class DumpServiceWithParams {
  final String? name;
  final int? value;
  DumpServiceWithParams({
    @factoryParam this.name,
    @factoryParam this.value,
  });
}
