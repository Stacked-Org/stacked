import 'dart:io';

import 'package:ansicolor/ansicolor.dart';
import 'package:stacked_tools/src/services/file_service.dart';

class ColorizedLogService {
  AnsiPen pen = AnsiPen()..white();

  /// "coloredPrint() takes a pen and a message, and prints the message to the console in the color of
  /// the pen."
  ///
  /// The pen is an object of type AnsiPen, which is a class that comes from the package. The message is
  /// a string
  ///
  /// Args:
  ///   pen (AnsiPen): The pen to use to color the text.
  ///   message (String): The message to be printed.
  void coloredPrint(AnsiPen pen, {required String message}) {
    stdout.writeln(pen(message));
  }

  /// `fileOutput` is a function that takes in a `FileModificationType` and a `String` and prints a
  /// message to the console based on the `FileModificationType`
  ///
  /// Args:
  ///   type (FileModificationType): The type of file modification that occurred.
  ///   message (String): The message to be printed
  void fileOutput(
      {required FileModificationType type, required String message}) {
    switch (type) {
      case FileModificationType.Create:
        coloredPrint(pen..green(), message: 'Created $message');
        break;
      case FileModificationType.Delete:
        coloredPrint(pen..red(), message: 'Deleted $message');
        break;
      case FileModificationType.Modify:
        coloredPrint(pen..blue(), message: 'Applied Modification $message');
        break;
      default:
        throw Exception('Invalid FileModificationType');
    }
  }

  /// `flutterOutput` is a function that takes a `message` as a required parameter and prints it to the
  /// console in yellow
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void flutterOutput({required String message}) {
    coloredPrint(pen..yellow(), message: message);
  }

  /// `stackedOutput` is a function that takes a required parameter `message` of type `String` and
  /// prints the message in cyan color
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void stackedOutput({required String message, bool isBold = false}) {
    coloredPrint(pen..cyan(bold: isBold), message: message);
  }

  /// `success` is a function that takes a required named parameter `message` of type `String` and
  /// prints a green message to the console
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void success({required String message}) {
    coloredPrint(pen..green(), message: message);
  }

  /// `warn` is a function that takes a required parameter `message` of type `String` and prints a
  /// warning message to the console
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void warn({required String message}) {
    coloredPrint(pen..rgb(r: 255, g: 165, b: 0), message: message);
  }

  /// `info` is a function that takes a required parameter `message` of type `String` and prints the
  /// message in white
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void info({required String message}) {
    coloredPrint(pen..white(), message: message);
  }

  /// `error` is a function that takes a required parameter `message` of type `String` and prints the
  /// message in red
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void error({required String message}) {
    coloredPrint(pen..red(), message: message);
  }
}
