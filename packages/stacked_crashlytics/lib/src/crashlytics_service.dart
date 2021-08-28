import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/foundation/assertions.dart';
import 'package:logger/logger.dart';

class CrashlyticsService {
  static CrashlyticsService? _instance;

  static Future<CrashlyticsService> getInstance() async {
    if (_instance == null) {
      _instance = CrashlyticsService._(FirebaseCrashlytics.instance);
    }

    return _instance!;
  }

  final FirebaseCrashlytics _crashlyticsService;
  CrashlyticsService._(
    this._crashlyticsService,
  );

  void recordFlutterErrorToCrashlytics(FlutterErrorDetails details) {
    try {
      _crashlyticsService.recordFlutterError(details);
    } catch (e) {
      _catchOrThrow(e);
    }
  }

  Future setUserIdToCrashlytics({String? id}) async {
    try {
      if (id != null) await _crashlyticsService.setUserIdentifier(id);
    } catch (e) {
      _catchOrThrow(e);
    }
  }

  Future logToCrashlytics(
    Level level,
    List<String> lines,
    StackTrace stacktrace, {
    required bool logwarnings,
  }) async {
    try {
      if (level == Level.error || level == Level.wtf) {
        await _crashlyticsService.recordError(
          lines.join('\n'),
          stacktrace,
          printDetails: true,
          fatal: true,
        );
      }
      if (level == Level.warning && logwarnings) {
        await _crashlyticsService.recordError(
          lines.join('\n'),
          stacktrace,
          printDetails: true,
        );
      }
      if (level == Level.info ||
          level == Level.verbose ||
          level == Level.debug) {
        await _crashlyticsService.log(lines.join('\n'));
      }
    } catch (exception) {
      _catchOrThrow(exception);
    }
  }

  Future setCustomKeysToTrack(String key, dynamic value) async {
    try {
      await _crashlyticsService.setCustomKey(key, value);
    } catch (e) {
      _catchOrThrow(e);
    }
  }

  // Be very careful when you excute this code it will crash the app
  // So, be sure to remove it after usage
  void crashApp() {
    try {
      _crashlyticsService.crash();
    } catch (e) {
      _catchOrThrow(e);
    }
  }

  void _catchOrThrow(dynamic exception) {
    final _exceptionString = exception.toString();
    final _isPluginConstantsException = _exceptionString
        .contains("pluginConstants['isCrashlyticsCollectionEnabled']");

    if (!_isPluginConstantsException) {
      throw exception;
    }
  }
}

class CrashlyticsOutput extends LogOutput {
  final bool logWarnings;
  CrashlyticsOutput({this.logWarnings = false});

  @override
  void output(OutputEvent event) {
    try {
      CrashlyticsService.getInstance().then((instance) {
        return instance.logToCrashlytics(
          event.level,
          event.lines,
          StackTrace.current,
          logwarnings: logWarnings,
        );
      });
    } catch (e) {
      print('CRASHLYTICS FAILED: $e');
    }
  }
}
