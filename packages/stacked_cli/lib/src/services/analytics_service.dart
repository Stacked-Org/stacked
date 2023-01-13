import 'package:usage/usage_io.dart';

class AnalyticsService {
  final AnalyticsIO _analytics = AnalyticsIO(
    'UA-41171112-5',
    'stacked-cli',
    'stacked_cli',
  );

  Future<void> appCreated({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'app',
      parameters: {'name': name},
    );
  }

  Future<void> createBottomSheetEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'bottom_sheet',
      parameters: {'name': name},
    );
  }

  Future<void> serviceCreated({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'service',
      parameters: {'name': name},
    );
  }

  Future<void> viewCreated({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'view',
      parameters: {'name': name},
    );
  }

  Future<void> serviceDeleted({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'service',
      parameters: {'name': name},
    );
  }

  Future<void> viewDeleted({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'view',
      parameters: {'name': name},
    );
  }

  Future<void> codeGenerated() async {
    await _analytics.sendEvent('command', 'generate');
  }

  Future<void> cliUpdated() async {
    await _analytics.sendEvent('command', 'update');
  }

  Future<void> templatesCompiled() async {
    await _analytics.sendEvent('command', 'compile');
  }
}
