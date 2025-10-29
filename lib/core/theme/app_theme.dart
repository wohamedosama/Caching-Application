import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();
  //? Light Theme
  static ThemeData lightTheme = FlexThemeData.light(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: false,
    useMaterial3: true,
    scheme: FlexScheme.sanJuanBlue,
    surfaceTint: Colors.transparent,
    textTheme: TextTheme(),
    fontFamily: GoogleFonts.rubik().fontFamily,
    dialogBackground: Colors.grey.shade100,
    subThemesData: FlexSubThemesData(
      blendOnLevel: 10,
      blendOnColors: false,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
  );
  static ThemeData darkTheme = FlexThemeData.light(
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    swapLegacyOnMaterial3: false,
    useMaterial3: true,
    scheme: FlexScheme.blueM3,
    surfaceTint: Colors.transparent,
    tabBarStyle: FlexTabBarStyle.forBackground,
    textTheme: TextTheme(),
    fontFamily: GoogleFonts.rubik().fontFamily,
    dialogBackground: Colors.grey.shade900,
    subThemesData: FlexSubThemesData(
      blendOnLevel: 20,
      useM2StyleDividerInM3: true,
      alignedDropdown: true,
      useInputDecoratorThemeInDialogs: true,
    ),
  );
}
