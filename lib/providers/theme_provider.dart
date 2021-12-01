import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
  return ThemeProvider();
});

class ThemeProvider extends ChangeNotifier {
  final ThemeData defaultLight = ThemeData.light();
  final ThemeData defaultDark = ThemeData.dark();

  ThemeData lightTheme = ThemeData.light();
  ThemeData darkTheme = ThemeData.dark();
}
