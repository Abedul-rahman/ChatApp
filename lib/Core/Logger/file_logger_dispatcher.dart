import 'dart:convert';
import 'dart:io';

import 'package:chatapp/Core/Logger/i_logger_dispatcher.dart';
import 'package:chatapp/Core/Logger/logger_service.dart';
import 'package:synchronized/synchronized.dart';

class FileLoggerDispatcher extends ILoggerDispatcher {
  FileLoggerDispatcher({
    required this.logFilePath,
    this.flushPerLogs = false,
    this.maxFileSizeInBytes = 1024 * 1024, // 1 MB
  }) : super("File") {
    _init();
  }
  final bool flushPerLogs;
  final String logFilePath;
  final int maxFileSizeInBytes;
  final Duration rotationDuration = const Duration(days: 1);

  final Lock _semaphore = Lock();

  IOSink? _sink;
  int _currentSizeBytes = 0;
  late DateTime _fileStartTime;

  void _init() {
    final file = File(logFilePath);
    if (file.existsSync()) {
      final stat = file.statSync();
      _fileStartTime = stat.modified;
      _currentSizeBytes = stat.size;
    } else {
      _currentSizeBytes = 0;
      _fileStartTime = DateTime.now();
    }
    _sink = file.openWrite(mode: FileMode.append);
  }

  @override
  Future<void> log(String message, LogLevel level) async {
    // Calculate byte size of the incoming message
    final messageBytes = utf8.encode("$message\n").length;

    await _semaphore.synchronized(() async {
      if (_shouldRotateFile(messageBytes)) {
        await _rotateFile();
      }

      _sink?.writeln(message);
      _currentSizeBytes += messageBytes;
      //not sure when the flush should happen, so I added an option for it, but it can be removed if not needed
      if (flushPerLogs) {
        await _sink?.flush();
      }
    });
  }

  bool _shouldRotateFile(int upcomingMessageSize) {
    if ((_currentSizeBytes + upcomingMessageSize) >= maxFileSizeInBytes) {
      return true;
    }
    if (DateTime.now().difference(_fileStartTime) >= rotationDuration) {
      return true;
    }
    return false;
  }

  Future<void> _rotateFile() async {
    await _sink?.flush();
    await _sink?.close();

    File logFile = File(logFilePath);
    if (await logFile.exists()) {
      final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
      await logFile.rename(
        "${logFilePath.replaceAll('.log', '')}_$timestamp.log",
      );
    }

    _currentSizeBytes = 0;
    _fileStartTime = DateTime.now();
    _sink = File(logFilePath).openWrite(mode: FileMode.append);
  }

  @override
  Future<void> dispose() async {
    await _semaphore.synchronized(() async {
      await _sink?.flush();
      await _sink?.close();
    });
  }
}
