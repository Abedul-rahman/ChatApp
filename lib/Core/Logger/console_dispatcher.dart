import 'package:chatapp/Core/Logger/i_logger_dispatcher.dart';
import 'package:chatapp/Core/Logger/logger_service.dart';
import 'package:flutter/foundation.dart';
import 'package:synchronized/synchronized.dart';

class ConsoleDispatcher extends ILoggerDispatcher {
  ConsoleDispatcher() : super("Console");
  final _semaphore = Lock();
  
  @override
  Future<void> log(String message, LogLevel level) async {
    await _semaphore.synchronized(() async {
      debugPrint(message);
    });
  }

 
  @override
  Future<void> dispose()async {
    return ;
    
  }
}
