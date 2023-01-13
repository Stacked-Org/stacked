import 'package:usage/usage_io.dart';

class AnalyticsService {
  final AnalyticsIO _analytics = AnalyticsIO(
    'UA-41171112-5',
    'stacked-cli',
    'stacked_cli',
  );

  Future<void> createAppEvent({required String name}) async {
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

  Future<void> createServiceEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'service',
      parameters: {'name': name},
    );
  }

  Future<void> createViewEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'view',
      parameters: {'name': name},
    );
  }

  Future<void> deleteServiceEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'service',
      parameters: {'name': name},
    );
  }

  Future<void> deleteViewEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'view',
      parameters: {'name': name},
    );
  }

  Future<void> generateCodeEvent() async {
    await _analytics.sendEvent('command', 'generate');
  }

  Future<void> updateCliEvent() async {
    await _analytics.sendEvent('command', 'update');
  }
}
