import 'package:universal_io/io.dart';

/// An abstraction over the Platform information so that we can have pure unit tests
class PlatformService {
  bool get isIos => Platform.isIOS;
  bool get isAndroid => Platform.isAndroid;

  bool get isMobilePlatform => isIos || isAndroid;
}
