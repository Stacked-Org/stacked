import 'dart:io';

import 'package:ansicolor/ansicolor.dart';

mixin ColorizedOutput {
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

  /// `fileCreatedOutput` is a function that takes a required parameter `message` of type `String` and
  /// prints a green colored message to the console
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void fileCreatedOutput({required String message}) {
    coloredPrint(AnsiPen()..green(), message: message);
  }

  /// `flutterOutput` is a function that takes a `message` as a required parameter and prints it to the
  /// console in yellow
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void flutterOutput({required String message}) {
    coloredPrint(AnsiPen()..yellow(), message: message);
  }

  /// `stackedOutput` is a function that takes a required parameter `message` of type `String` and
  /// prints the message in cyan color
  ///
  /// Args:
  ///   message (String): The message to be printed.
  void stackedOutput({required String message}) {
    coloredPrint(AnsiPen()..cyan(), message: message);
  }

  /// `successOutput` is a function that takes in a boolean and a string, and prints the string in green
  /// if the boolean is true, and red if the boolean is false
  /// 
  /// Args:
  ///   success (bool): Whether the output should be green or red. Defaults to true
  ///   message (String): The message to be printed.
  void successOutput({bool success = true, required String message}) {
    coloredPrint(success ? (AnsiPen()..green()) : (AnsiPen()..red()),
        message: message);
  }
}
