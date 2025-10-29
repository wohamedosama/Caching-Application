import 'package:logger/logger.dart';

class LogHelper {
  // Singleton instance
  static final LogHelper _instance = LogHelper._internal();
  factory LogHelper() => _instance;
  LogHelper._internal();

  final logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
  );

  // Error logging method
  void logError({
    required String message,
    dynamic error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    final logMessage = tag != null ? '[$tag] $message' : message;
    logger.e(logMessage, error: error, stackTrace: stackTrace);
  }

  // Warning logging method
  void logWarning(String message, {Object? error}) {
    logger.w(message, error: error);
  }

  // Info logging method
  void logInfo(String message) {
    logger.i(message);
  }

  // Debug logging method
  void logDebug(String message) {
    logger.d(message);
  }

  // Success logging method
  void logSuccess(String message) {
    logger.t(message);
  }

  // API Request logging
  void logRequest(String method, String url, {Map<String, dynamic>? data}) {
    logger.d('🚀 Request: $method $url', error: data);
  }

  // API Response logging
  void logResponse(String method, String url, dynamic response) {
    logger.d('✅ Response: $method $url', error: response);
  }

  // API Error logging
  void logApiError(
    String method,
    String url,
    dynamic error, {
    int? statusCode,
    Map<String, dynamic>? responseData,
  }) {
    logger.e(
      '❌ API Error: $method $url',
      error: {
        'statusCode': statusCode,
        'error': error,
        'responseData': responseData,
      },
    );
  }
}
