import 'dart:developer' as developer;
import 'package:logging/logging.dart';

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    final message =
        record.level >= Level.WARNING
            ? _formatDetailed(record)
            : _formatSimple(record);

    developer.log(
      message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      // errorとstackTraceは「WARNING」以上
      error: record.level >= Level.WARNING ? record.error : null,
      stackTrace: record.level >= Level.WARNING ? record.stackTrace : null,
    );
  });
}

// 簡潔なログフォーマット定義
String _formatSimple(LogRecord record) {
  return '[${record.level.name}] ${record.loggerName}: ${record.message}';
}

// 詳細なログフォーマット定義
String _formatDetailed(LogRecord record) {
  final buffer = StringBuffer();
  buffer.write(
    '[${record.level.name}] ${record.loggerName}: ${record.message}',
  );

  if (record.error != null) {
    buffer.write(' | Error: ${record.error.runtimeType} - ${record.error}');
  }

  return buffer.toString();
}
