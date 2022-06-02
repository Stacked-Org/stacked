import 'package:stacked_core/stacked_core.dart';

import '../../../helpers/basic_dialog.dart';
import '../../../helpers/complex_dialog.dart';

@StackedApp(
  dialogs: [
    StackedDialog(classType: BasicDialog),
    StackedDialog(classType: ComplexDialog),
  ],
)
class App {
  /** This class has no puporse besides housing the annotation that generates the required functionality **/
}
