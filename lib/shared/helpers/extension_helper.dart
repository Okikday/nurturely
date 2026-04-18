import 'dart:convert';

import 'package:flutter/material.dart';

extension ExtensionHelper on BuildContext {
  BuildContext get context => this;
  ThemeData get theme => Theme.of(context);
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  MediaQueryData get mediaQuery => MediaQuery.of(context);
  Size get screenSize => MediaQuery.of(this).size;
  double get deviceWidth => screenSize.width;
  double get deviceHeight => screenSize.height;
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets get padding => MediaQuery.paddingOf(this);
  double get topPadding => padding.top;
  double get bottomPadding => padding.bottom;
}

extension StringExtension on String {
  Map get decodeJson => jsonDecode(this);
}

extension ColorsExtension on Color {
  Color lightenColor([double? value]) => HSLColor.fromColor(this).withLightness((value ?? 0.9)).toColor();
}
