import 'package:chatapp/Utils/constants.dart';
import 'package:flutter/foundation.dart';

class UrlBuilder {
  static Uri get baseUri {
    final configuredBaseUrl = Constants.serverBaseUrl.trim();
    if (configuredBaseUrl.isNotEmpty) {
      return Uri.parse(_trimTrailingSlash(configuredBaseUrl));
    }

    if (kIsWeb) {
      return Uri.base;
    }

    return Uri(
      scheme: Constants.serverScheme,
      host: Constants.defaultServerHost,
      port: Constants.serverPort,
    );
  }

  static String get baseUrl => _origin(baseUri);

  static String getChatHubUrl() {
    return '${baseUri.toString()}/chathub';
  }

  static String _origin(Uri uri) {
    final normalizedHost = _normalizeHost(uri.host);
    final origin = uri
        .replace(host: normalizedHost, path: '', query: null, fragment: null)
        .toString();
    return _trimTrailingSlash(origin);
  }

  static String _normalizeHost(String host) {
    if (kIsWeb) {
      return host;
    }

    if (defaultTargetPlatform != TargetPlatform.android) {
      return host;
    }

    return host == 'localhost' ? '10.0.2.2' : host;
  }

  static String _trimTrailingSlash(String value) {
    return value.endsWith('/') ? value.substring(0, value.length - 1) : value;
  }
}
