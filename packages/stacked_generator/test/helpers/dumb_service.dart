import 'package:stacked_core/stacked_core.dart';

abstract class AbstractDumpService {}

class DumpService implements AbstractDumpService {
  String? name;
  int? value;
  static DumpService? _instance;

  static DumpService getInstance() {
    _instance ??= DumpService();

    return _instance!;
  }

  static Future<DumpService> presolve() async {
    _instance ??= DumpService();

    return _instance!;
  }
}

class DumpServiceWithOneParam {
  final String? name;
  final int? value;
  const DumpServiceWithOneParam({
    @factoryParam this.name,
    this.value,
  });
}

class DumpServiceWithParams {
  final String? name;
  final int? value;
  const DumpServiceWithParams({
    @factoryParam this.name,
    @factoryParam this.value,
  });
}
