class Helper {
  static DateTime toLocalDateTime(DateTime dateTime) {
    return dateTime.toLocal();
  }
    static Map<String, dynamic> asMap(Object result) {
    if (result is Map<String, dynamic>) {
      return result;
    }

    if (result is Map) {
      return Map<String, dynamic>.from(result);
    }

    throw Exception('Unexpected SignalR payload type: ${result.runtimeType}');
  }

}
