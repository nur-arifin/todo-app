import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final box = GetStorage();
  bool get isDark => box.read('darkmode') ?? false;
  ThemeData get theme => isDark ? darkTheme : lightTheme;
  void changeTheme(bool val) => box.write('darkmode', val);

  // Light Theme
  final lightTheme = ThemeData.light().copyWith(
    brightness: Brightness.light,
    backgroundColor: Color(0xfff5f5f5),
    scaffoldBackgroundColor: Color(0xfff5f5f5),
    primaryColor: Colors.blueAccent.shade100,
    appBarTheme: AppBarTheme(
      brightness: Brightness.light,
    ),
    cardTheme: CardTheme(
      color: Color(0xfff5f5f5),
    ),
  );

  // Dark Theme
  final darkTheme = ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      backgroundColor: Color(0xFF212121),
    ),
    cardTheme: CardTheme(
      color: Color(0xFF212121),
    ),
  );
}
