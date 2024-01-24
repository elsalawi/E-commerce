import 'dart:io';

import 'package:flutter/material.dart';
import 'colors.dart' as colors;

ThemeData appTheme(context) => ThemeData(
      primaryColor: colors.primaryColor,
      scaffoldBackgroundColor: colors.backgroundColor,
      outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                  primary: colors.primaryColor,
                  side: const BorderSide(color: colors.primaryColor, width: 1),
            ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                  primary: colors.primaryColor,
            ),
      ),
      appBarTheme: AppBarTheme(
            color: colors.primaryColor,
            iconTheme: IconTheme.of(context).copyWith(color: Colors.white),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: colors.primaryColor,
            foregroundColor: Colors.white,
      ),
);