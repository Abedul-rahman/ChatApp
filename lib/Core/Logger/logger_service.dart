import 'dart:async';

import 'package:chatapp/Core/Logger/i_logger_dispatcher.dart';
import 'package:chatapp/Core/Logger/logs_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum LogLevel {
  debug(0),
  info(1),
  warning(2),
  error(3),
  critical(4);

  const LogLevel(this.level);
  final int level;
  bool loggable(LogLevel currentLevel) => level >= currentLevel.level;
}

class RateLimiter {
  RateLimiter({required this.maxRate, required this.timeWindow});
  final int maxRate;
  final Duration timeWindow;
  List<DateTime> _logTimestamps = [];
  bool exceeded() {
    final now = DateTime.now();
    _logTimestamps = _logTimestamps
        .where((t) => now.difference(t) < timeWindow)
        .toList();
    if (_logTimestamps.length >= maxRate) {
      return true;
    }
    _logTimestamps.add(now);
    return false;
  }
}

class LoggerService extends GetxController {
  static LoggerService get to => Get.find<LoggerService>();
  Future<void> init(
    List<ILoggerDispatcher> dispatchers,
    List<WrapperCallback> wrappers,
   { LogLevel minLevel = LogLevel.info,
    RateLimiter? rateLimiter ,
  }) async {
    dispatchers.forEach(addDispatcher);
    for (var wrapper in wrappers) {
      _wrapper.addWrapper(wrapper);
    }
    _minLevel = minLevel;
    if (rateLimiter != null) {
      _rateLimiter = rateLimiter;
    }
  }

  final Duration _dispatchTimeout = const Duration(seconds: 5);
  final Map<String,ILoggerDispatcher> _dispatchers = {};
  final LogsWrapper _wrapper = LogsWrapper();
  var _rateLimiter =RateLimiter(
    maxRate: 100,
    timeWindow: const Duration(minutes: 1),
  ); 

  late LogLevel _minLevel ;

  void setMinLevel(LogLevel level) {
    _minLevel = level;
  }

  void addDispatcher(ILoggerDispatcher dispatcher) {
    _dispatchers[dispatcher.name] = dispatcher;
  }

  void removeDispatcher(ILoggerDispatcher dispatcher) {
    _dispatchers.remove(dispatcher.name);
  }

  Future<void> log(
    String message, {
    LogLevel level = LogLevel.info,
    Set<String> tags = const {},
  }) async {
    if (!level.loggable(_minLevel)) return;

    if (_rateLimiter.exceeded()) {
      debugPrint('Log rate limit exceeded, dropping message');
      return;
    }

    message = _wrapper.wrap(message, level, tags);

    await _dispatchLogs(message, level);
  }
  Future<void> logList(
    List<String>messages,{
    LogLevel level = LogLevel.info,
    Set<String> tags = const {},
  })async{
    if (!level.loggable(_minLevel)) return;
    if (_rateLimiter.exceeded()) {
      debugPrint('Log rate limit exceeded, dropping messages');
      return;
    }
    var wrappedMessages = messages.map((m) => _wrapper.wrap(m, level, tags)).toList();
    for(var message in wrappedMessages){

      await _dispatchLogs(message, level);
    } 
  }

  Future<void> _dispatch(
    ILoggerDispatcher dispatcher,
    String message,
    LogLevel type,
  ) async {
    return dispatcher
        .log(message, type)
        .timeout(
          _dispatchTimeout,
          onTimeout: () {
            debugPrint('Dispatcher ${dispatcher.name} timed out');
            dispatcher.active = false;
          },
        );
  }

  Future<void> _dispatchLogs(String message, LogLevel level) async {
    for (var dispatcher in _dispatchers.values) {
      if (!dispatcher.active) continue;

      await _dispatch(dispatcher, message, level);
    }
  }


  Future<void> logUnhandledError(
    Object error,
    StackTrace stackTrace, {
    required String source,
  }) async {
    final messages = List<String>.empty(growable: true);
      messages.add('Unhandled error captured');
      messages.add('source: $source');
      messages.add('type: ${error.runtimeType}');
      messages.add('error: $error');
      messages.add('stackTrace: $stackTrace');

    await logList(
      messages,
      level: LogLevel.critical,
      tags: {'global-error', source},
    );
  }

  @override
  void dispose() {
    for (var dispatcher in _dispatchers.values) {
      unawaited(dispatcher.dispose());
    }
    super.dispose();
  }
}
