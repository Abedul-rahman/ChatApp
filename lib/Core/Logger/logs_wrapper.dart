import 'package:chatapp/Core/Logger/logger_service.dart';

typedef WrapperCallback =
    String Function(String message, LogLevel level, Set<String> tags);

class LogsWrapper {
  final List<WrapperCallback> _callbacks = [];

  String wrap(String message, LogLevel level, Set<String> tags) {
    for (var callback in _callbacks) {
      message = callback(message, level, tags);
    }
    return message;
  }

  void addWrapper(WrapperCallback callback) {
    _callbacks.add(callback);
  }

  void removeWrapper(WrapperCallback callback) {
    _callbacks.remove(callback);
  }
}

extension WrapperExtension on String {
  String addType(LogLevel type) {
    return '${type.name}: $this';
  }

  String addData() {
    return '${DateTime.now().toIso8601String()} $this';
  }

  String addTags(Set<String> tags) {
    if (tags.isEmpty) return this;
    var sortedTags = tags.toList()..sort();
    return '[${sortedTags.join(',')}] $this';
  }

  String wrap(LogLevel type, Set<String> tags) {
    return addData().addType(type).addTags(tags);
  }

  static String addWrappers(String message, LogLevel level, Set<String> tags) {
    return message.wrap(level, tags);
  }
}
