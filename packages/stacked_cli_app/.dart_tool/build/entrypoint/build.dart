// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:mockito/src/builder.dart' as _i2;
import 'package:source_gen/builder.dart' as _i3;
import 'package:stacked_generator/builder.dart' as _i4;
import 'dart:isolate' as _i5;
import 'package:build_runner/build_runner.dart' as _i6;
import 'dart:io' as _i7;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
      r'mockito:mockBuilder', [_i2.buildMocks], _i1.toDependentsOf(r'mockito'),
      hideOutput: false),
  _i1.apply(r'source_gen:combining_builder', [_i3.combiningBuilder],
      _i1.toNoneByDefault(),
      hideOutput: false, appliesBuilders: const [r'source_gen:part_cleanup']),
  _i1.apply(r'stacked_generator:stackedFormGenerator',
      [_i4.stackedFormGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedLocatorGenerator',
      [_i4.stackedLocatorGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedLoggerGenerator',
      [_i4.stackedLoggerGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.apply(r'stacked_generator:stackedRouterGenerator',
      [_i4.stackedRouterGenerator], _i1.toDependentsOf(r'stacked_generator'),
      hideOutput: false),
  _i1.applyPostProcess(r'source_gen:part_cleanup', _i3.partCleanup)
];
void main(List<String> args, [_i5.SendPort? sendPort]) async {
  var result = await _i6.run(args, _builders);
  sendPort?.send(result);
  _i7.exitCode = result;
}
