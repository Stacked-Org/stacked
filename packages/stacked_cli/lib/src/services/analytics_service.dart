import 'package:usage/usage_io.dart';

/// Provides functionality to interact with Google Analytics
class AnalyticsService {
  static const environment = String.fromEnvironment(
    'environment',
    defaultValue: 'development',
  );

  AnalyticsService() {
    _initialize();
  }

  final AnalyticsIO _analytics = AnalyticsIO(
    'UA-41171112-5',
    'stacked-cli',
    'stacked_cli',
  );

  /// Initializes Google Analytics depending of the [environment] declaration.
  ///
  /// When value is production, should enable Analytics. Otherwise, should
  /// disable Analytics.
  ///
  /// When no [environment] value is passed, should disable Analytics.
  Future<void> _initialize() async {
    if (environment == 'production') {
      _analytics.enabled = true;
    } else {
      _analytics.enabled = false;
    }
  }

  /// This will wait until all outstanding analytics requests have completed,
  /// or until the specified duration has elapsed.
  Future<void> _waitLastPingOrCloseAtTimeout() async {
    await _analytics.waitForLastPing(
      timeout: const Duration(milliseconds: 200),
    );
    _analytics.close();
  }

  /// Sends create app command event
  Future<void> createAppEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'app',
      parameters: {'name': name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create bottom sheet command event
  Future<void> createBottomSheetEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'bottom_sheet',
      parameters: {'name': name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create dialog command event
  Future<void> createDialogEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'dialog',
      parameters: {'name': name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create service command event
  Future<void> createServiceEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'service',
      parameters: {'name': name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create view command event
  Future<void> createViewEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'view',
      parameters: {'name': name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends delete service command event
  Future<void> deleteServiceEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'service',
      parameters: {'name': name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends delete view command event
  Future<void> deleteViewEvent({required String name}) async {
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'view',
      parameters: {'name': name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends generate command event
  Future<void> generateCodeEvent() async {
    await _analytics.sendEvent('command', 'generate');
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends update command event
  Future<void> updateCliEvent() async {
    await _analytics.sendEvent('command', 'update');
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends exception event
  Future<void> logExceptionEvent({
    ExceptionMode mode = ExceptionMode.handledException,
    required String runtimeType,
    required String message,
    String stackTrace = 'not available',
  }) async {
    await _analytics.sendEvent(
      mode.toString(),
      runtimeType,
      label: message,
      parameters: {'stackTrace': stackTrace},
    );
    await _waitLastPingOrCloseAtTimeout();
  }
}

enum ExceptionMode {
  handledException,
  unhandledException,
}
