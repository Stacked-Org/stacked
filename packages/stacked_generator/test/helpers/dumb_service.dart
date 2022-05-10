import 'package:stacked_core/stacked_core.dart';

abstract class AbstractDumpService {}

class DumpService implements AbstractDumpService {
  String? name;
  int? value;
  DumpService();
}

class DumpServiceWithParams {
  final String? name;
  final int? value;
  DumpServiceWithParams({
    @factoryParam this.name,
    @factoryParam this.value,
  });
}
