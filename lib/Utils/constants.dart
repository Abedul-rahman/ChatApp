
class Constants {
  static const String appName = 'Chat App';
  static const String serverBaseUrl = String.fromEnvironment(
    'CHAT_SERVER_BASE_URL',
    defaultValue: 'https://evventa.epyasolutions.com/Chatting.rest',
  );
  static const String serverScheme = String.fromEnvironment(
    'CHAT_SERVER_SCHEME',
    defaultValue: 'https',
  );
  static const String serverHostOverride = String.fromEnvironment(
    'CHAT_SERVER_HOST',
    defaultValue: '',
  );
  static const int serverPort = int.fromEnvironment(
    'CHAT_SERVER_PORT',
    defaultValue: 5017,
  );

  static const Duration defaultSignalrRequestTimeout = Duration(seconds: 15);
  static const Duration defaultSignalrServerTimeout = Duration(seconds: 30);
  static const Duration defaultSignalrKeepAliveInterval = Duration(seconds: 15);
  static const List<int> defaultSignalrReconnectDelaysInMilliseconds = <int>[
    0,
    2000,
    5000,
    10000,
    20000,
  ];

  static String get defaultServerHost {
    if (serverHostOverride.isNotEmpty) {
      return serverHostOverride;
    }
        return 'localhost';
  }
}
