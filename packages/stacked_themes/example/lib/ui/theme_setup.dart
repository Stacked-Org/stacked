import 'package:flutter/material.dart';

List<ThemeData> getThemes() {
  return [
    ThemeData(backgroundColor: Colors.blue, accentColor: Colors.yellow),
    ThemeData(backgroundColor: Colors.white, accentColor: Colors.green),
    ThemeData(backgroundColor: Colors.purple, accentColor: Colors.green),
    ThemeData(backgroundColor: Colors.black, accentColor: Colors.red),
    ThemeData(backgroundColor: Colors.red, accentColor: Colors.blue),
  ];
}
