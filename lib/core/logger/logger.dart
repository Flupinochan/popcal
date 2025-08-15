import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logging/logging.dart';

void setupLogging() {
  Logger.root.clearListeners();
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final message = _logFormat(record);
    debugPrint(message);
  });
}

String _logFormat(LogRecord record) {
  final dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');

  final buffer =
      StringBuffer()..write(
        '[${record.level.name}] [${dateTimeFormat.format(record.time)}] [${record.loggerName}] ${record.message}',
      );

  if (record.error != null) {
    buffer.write(' | Error: ${record.error.runtimeType} - ${record.error}');
  }

  return buffer.toString();
}
