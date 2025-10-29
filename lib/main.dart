import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_caching/caching_app.dart';
import 'package:flutter_caching/core/helper/log_helper.dart';

void main() {
  // Initialize logger
  final logger = LogHelper();

  // Set up global error handlers
  FlutterError.onError = (FlutterErrorDetails details) {
    logger.logError(
      message: '❌ Flutter Error: ${details.exceptionAsString()}',
      error: details.exception,
      stackTrace: details.stack,
      tag: 'FlutterError',
    );

    // In debug mode, show the error in the console
    if (kDebugMode) {
      FlutterError.presentError(details);
    }
  };

  // Handle asynchronous errors that aren't caught by Flutter
  PlatformDispatcher.instance.onError = (error, stack) {
    logger.logError(
      message: '❌ Unhandled Async Error: $error',
      error: error,
      stackTrace: stack,
      tag: 'PlatformDispatcher',
    );
    return true;
  };

  // Run the app with error handling
  runZonedGuarded(
    () {
      runApp(const CachingApp());
    },
    (error, stack) {
      logger.logError(
        message: '❌ Unhandled Zone Error: $error',
        error: error,
        stackTrace: stack,
        tag: 'Zone',
      );
    },
  );
}
