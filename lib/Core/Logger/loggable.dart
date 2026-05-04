import 'package:chatapp/Core/Logger/logger_service.dart';
import 'package:get/get.dart';

mixin Loggable {
  LoggerService get logger => Get.find<LoggerService>();

  List<String> get loggerTags => [runtimeType.toString()];

  Future<void> debug(String message, {List<String> tags = const []}) {
    return _log(message, level: LogLevel.debug, tags: tags);
  }

  Future<void> info(String message, {List<String> tags = const []}) {
    return _log(message, level: LogLevel.info, tags: tags);
  }

  Future<void> warning(String message, {List<String> tags = const []}) {
    return _log(message, level: LogLevel.warning, tags: tags);
  }

  Future<void> error(String message, {List<String> tags = const []}) {
    return _log(message, level: LogLevel.error, tags: tags);
  }

  Future<void> critical(String message, {List<String> tags = const []}) {
    return _log(message, level: LogLevel.critical, tags: tags);
  }

  Future<void> _log(
    String message, {
    LogLevel level = LogLevel.info,
    List<String> tags = const [],
  }) async {
    await logger.log(
      message,
      level: level,
      tags: {...loggerTags, ...tags},
    );
  }
}
