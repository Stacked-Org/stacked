import 'package:googleapis/logging/v2.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/services.dart' show rootBundle;
import 'package:new_architecture/app/app.locator.dart';

import 'package:googleapis/logging/v2.dart';
import 'package:googleapis_auth/auth_io.dart';

const _SCOPES = ['https://www.googleapis.com/auth/logging.write'];

class CloudLoggingService {
  ServiceAccountCredentials? _credentials;
  bool _initialised = false;

  AutoRefreshingAuthClient? _authClient;
  LoggingApi? _loggingApi;
  var resource = MonitoredResource()..type = 'global';

  final labels = <String, String>{
    'project_id': 'customer-app-dc655',
    'environment': foundation.kDebugMode || foundation.kProfileMode
        ? 'Development'
        : 'Production',
  };

  Future initialise() async {
    try {
      var credentialJson = await rootBundle
          .loadString('assets/watchme/customer-app-dc655-49fd8fc079ff.json');

      _credentials = ServiceAccountCredentials.fromJson(credentialJson);
      _authClient = await clientViaServiceAccount(_credentials!, _SCOPES);
      _loggingApi = LoggingApi(_authClient!);
      _initialised = true;
    } catch (e) {
      print(
          'STACKDRIVER: GoogleApiService setup failed for stack driver logging. $e');
      _initialised = false;
    }
  }

  String _getSeverityFromLevel(Level level) {
    switch (level) {
      case Level.wtf:
        return 'EMERGENCY';
      case Level.error:
        return 'ERROR';
      case Level.warning:
        return 'WARNING';
      case Level.info:
        return 'INFO';
      case Level.debug:
        return 'DEBUG';

      default:
        return 'DEBUG';
    }
  }

  void writeEntry(Level level, List<String> lines) {
    if (_initialised) {
      LogEntry logEntry = LogEntry();
      logEntry.logName = "projects/customer-app-dc655/logs/customer-app";
      logEntry.jsonPayload = {'message': lines.join('\n')};
      logEntry.resource = resource;
      labels['level'] = level.toString();
      logEntry.labels = labels;
      logEntry.severity = _getSeverityFromLevel(level);

      var request = WriteLogEntriesRequest();
      request.entries = [logEntry];

      _loggingApi!.entries
          .write(request)
          .catchError((error) => print('STACKDRIVER: write error. $error'));
    }
  }

  void setIdentifiers({required String userId, required String appId}) {
    labels['user_id'] = userId;
    labels['app_instance_id'] = appId;
  }
}
