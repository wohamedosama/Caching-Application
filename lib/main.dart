import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_caching/caching_app.dart';
import 'package:flutter_caching/core/dependency_injection/di.dart';
import 'package:flutter_caching/core/local/home_data_base_services.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await HomeDataBaseServices().initDataBase();
  await initGetIt();
  runApp(const CachingApp());
}
