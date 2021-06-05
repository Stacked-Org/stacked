import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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
    _crashlyticsService.recordFlutterError(details);
  }

  Future setUserIdToCrashlytics({String? id}) async {
    if (id != null) await _crashlyticsService.setUserIdentifier(id);
  }

  Future logToCrashlytics(
      Level level, List<String> lines, StackTrace stacktrace,
      {bool logwarnings = false}) async {
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
    if (level == Level.info || level == Level.verbose || level == Level.debug) {
      await _crashlyticsService.log(lines.join('\n'));
    }
  }

  Future setCustomKeysToTrack(String key, dynamic value) async {
    await _crashlyticsService.setCustomKey(key, value);
  }

  // Be very careful when you excute this code it will crash the app
  // So, be sure to remove it after usage
  void crashApp() {
    _crashlyticsService.crash();
  }
}

class CrashlyticsOutput extends LogOutput {
  @override
  void output(OutputEvent event) {
    try {
      CrashlyticsService.getInstance().then((instance) => instance
          .logToCrashlytics(event.level, event.lines, StackTrace.current));
    } catch (e) {
      print('CRASHLYTICS FAILED: $e');
    }
  }
}
