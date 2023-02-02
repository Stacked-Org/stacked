import 'package:stacked_cli/src/locator.dart';
import 'package:usage/usage_io.dart';

import 'pub_service.dart';

/// Provides functionality to interact with Google Analytics
class AnalyticsService {
  // Custom Dimension [1] - Version
  static const String kcdVersion = 'cd1';

  // Custom Dimension [2] - Name
  static const String kcdName = 'cd2';

  final AnalyticsIO _analytics = AnalyticsIO(
    'UA-41171112-5',
    'stacked-cli',
    'stacked_cli',
  );

  /// Is this the first time the tool has run?
  bool get isFirstRun => _analytics.firstRun;

  /// Will analytics data be sent?
  bool get enabled => _analytics.enabled;

  /// Enables or disables sending of analytics data.
  void enable(bool value) {
    _analytics.enabled = value;
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
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'app',
      parameters: {kcdVersion: version, kcdName: name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create bottom sheet command event
  Future<void> createBottomSheetEvent({required String name}) async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'bottom_sheet',
      parameters: {kcdVersion: version, kcdName: name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create dialog command event
  Future<void> createDialogEvent({required String name}) async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'dialog',
      parameters: {kcdVersion: version, kcdName: name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create service command event
  Future<void> createServiceEvent({required String name}) async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'service',
      parameters: {kcdVersion: version, kcdName: name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends create view command event
  Future<void> createViewEvent({required String name}) async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'create',
      label: 'view',
      parameters: {kcdVersion: version, kcdName: name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends delete service command event
  Future<void> deleteServiceEvent({required String name}) async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'service',
      parameters: {kcdVersion: version, kcdName: name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends delete view command event
  Future<void> deleteViewEvent({required String name}) async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'delete',
      label: 'view',
      parameters: {kcdVersion: version, kcdName: name},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends generate command event
  Future<void> generateCodeEvent() async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'generate',
      parameters: {kcdVersion: version},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends update command event
  Future<void> updateCliEvent() async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      'command',
      'update',
      parameters: {kcdVersion: version},
    );
    await _waitLastPingOrCloseAtTimeout();
  }

  /// Sends exception event
  Future<void> logExceptionEvent({
    Level level = Level.error,
    required String runtimeType,
    required String message,
    String stackTrace = 'Not Available',
  }) async {
    final version = await locator<PubService>().getCurrentVersion();
    await _analytics.sendEvent(
      level.toString(),
      '[$runtimeType] $message',
      label: 'StackTrace:\n$stackTrace',
      parameters: {kcdVersion: version},
    );
    await _waitLastPingOrCloseAtTimeout();
  }
}

enum Level {
  debug,
  info,
  warning,
  error;

  @override
  String toString() {
    return 'LOG::${name.toUpperCase()}';
  }
}
