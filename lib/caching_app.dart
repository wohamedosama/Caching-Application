import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_caching/core/dependency_injection/di.dart';
import 'package:flutter_caching/core/theme/app_theme.dart';
import 'package:flutter_caching/features/home/cubit/product_cubit.dart';
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
      home: BlocProvider(
        create: (context) => getIt<ProductCubit>()..getAllProducts(),
        child: HomeScreen(),
      ),
    );
  }
}
