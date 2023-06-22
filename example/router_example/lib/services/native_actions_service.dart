import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stacked/stacked_annotations.dart';

class NativeActionsService implements InitializableDependency {
  late PackageInfo _packageInfo;

  String _deviceId = '';
  String _operativeSystem = '';

  String get appVersion =>
      '${_packageInfo.version}-${_packageInfo.buildNumber}';

  String get pureVersion => _packageInfo.version;

  String get bundleId => _packageInfo.packageName;

  String get deviceId => _deviceId;

  String get operativeSystem => _operativeSystem;

  @override
  Future<void> init() async {
    _packageInfo = await PackageInfo.fromPlatform();

    final deviceInfoPlugin = DeviceInfoPlugin();

    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        final info = await deviceInfoPlugin.iosInfo;
        _deviceId = '${info.identifierForVendor}';
        _operativeSystem = '${info.systemName} ${info.systemVersion}';
        break;
      case TargetPlatform.android:
        final info = await deviceInfoPlugin.androidInfo;
        _deviceId = info.serialNumber;
        _operativeSystem =
            '${info.version.release}, SDK:${info.version.sdkInt}';
        break;
      case TargetPlatform.macOS:
        // When running on browser is getting wrong data
        if (kIsWeb) return;

        final info = await deviceInfoPlugin.macOsInfo;
        _deviceId = '${info.systemGUID}';
        _operativeSystem = '${info.hostName} ${info.osRelease}';
        break;
      case TargetPlatform.windows:
        final info = await deviceInfoPlugin.windowsInfo;
        _deviceId = info.deviceId;
        _operativeSystem = '${info.productName} [${info.releaseId}]';
        break;
      case TargetPlatform.linux:
        final info = await deviceInfoPlugin.linuxInfo;
        _deviceId = '${info.machineId}';
        _operativeSystem = info.prettyName;
        break;
      default:
        final info = await deviceInfoPlugin.webBrowserInfo;
        _deviceId = '${info.vendor}';
        _operativeSystem = info.browserName.name;
    }
  }
}
