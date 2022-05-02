import 'package:get/get.dart' as G;

/// Indicates if snack is going to start at the [TOP] or at the [BOTTOM]
enum SnackPosition { TOP, BOTTOM }

/// Indicates if snack will be attached to the edge of the screen or not
enum SnackStyle { FLOATING, GROUNDED }

extension ToGetSnackPosition on SnackPosition {
  G.SnackPosition get toGet {
    switch (this) {
      case SnackPosition.TOP:
        return G.SnackPosition.TOP;

      default:
        return G.SnackPosition.BOTTOM;
    }
  }
}

extension ToGetSnackStyle on SnackStyle {
  G.SnackStyle get toGet {
    switch (this) {
      case SnackStyle.GROUNDED:
        return G.SnackStyle.GROUNDED;

      default:
        return G.SnackStyle.FLOATING;
    }
  }
}
