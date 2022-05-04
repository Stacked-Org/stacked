import 'package:get/get.dart' as G;

enum Transition {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  rightToLeftWithFade,
  leftToRightWithFade,
  zoom,
}

extension ToGetTransition on Transition {
  G.Transition get toGet {
    switch (this) {
      case Transition.fade:
        return G.Transition.fade;
      case Transition.leftToRight:
        return G.Transition.leftToRight;
      case Transition.rightToLeft:
        return G.Transition.rightToLeft;
      case Transition.upToDown:
        return G.Transition.upToDown;
      case Transition.downToUp:
        return G.Transition.downToUp;
      case Transition.zoom:
        return G.Transition.zoom;
      case Transition.leftToRightWithFade:
        return G.Transition.leftToRightWithFade;
      case Transition.rightToLeftWithFade:
        return G.Transition.rightToLeftWithFade;

      default:
        return G.Transition.rightToLeft;
    }
  }
}
