import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

/// An abstraction over the Platform information so that we can have pure unit tests
class PlatformService {
  // Check if currently using web
  bool get isWeb => kIsWeb;

  bool get isIos => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;

  bool get isMobilePlatform => isIos || isAndroid;
}
