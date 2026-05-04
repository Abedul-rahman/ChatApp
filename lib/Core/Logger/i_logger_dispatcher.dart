import 'package:chatapp/Core/Logger/logger_service.dart';

abstract class ILoggerDispatcher {
  ILoggerDispatcher( this.name);
  final String name;

  bool active =true;

Future<void> log(String message,LogLevel level) async{}
Future<void> dispose() ;
}
