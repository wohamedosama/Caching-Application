import 'package:flutter/material.dart';
import 'package:flutter_caching/core/theme/app_theme.dart';
import 'package:flutter_caching/features/home/presentation/screens/home_screen.dart';

class CachingApp extends StatelessWidget {
  const CachingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      themeMode: ThemeMode.system,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
