import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(),
    colorScheme: ColorScheme.light(
      background: const Color.fromRGBO(140, 162, 217, 1),
      primary: Colors.grey[200]!,
      secondary: Colors.grey[300]!,
      tertiary: Colors.black,
    ));
