import 'package:chatapp/Utils/constants.dart';
import 'package:chatapp/Utils/url_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:signalr_netcore/signalr_client.dart';

abstract class SignalrService extends GetxService {
  static SignalrService get to => Get.find<SignalrService>();
  late final HubConnection _connection;
  final Map<String, List<MethodInvocationFunc>> _eventHandlers = {};

  HubConnectionState? get connectionState => _connection.state;
  Stream<HubConnectionState> get connectionStateStream =>
      _connection.stateStream;

  bool get isConnected => connectionState == HubConnectionState.Connected;
  @override
  void onInit() {
    super.onInit();
    _connection = HubConnectionBuilder()
        .withUrl(
          UrlBuilder.getChatHubUrl(),
          options: HttpConnectionOptions(
            requestTimeout:
                Constants.defaultSignalrRequestTimeout.inMilliseconds,
          ),
        )
        .withAutomaticReconnect(
          retryDelays: Constants.defaultSignalrReconnectDelaysInMilliseconds,
        )
        .build();
    _connection.serverTimeoutInMilliseconds =
        Constants.defaultSignalrServerTimeout.inMilliseconds;
    _connection.keepAliveIntervalInMilliseconds =
        Constants.defaultSignalrKeepAliveInterval.inMilliseconds;
  }

  @protected
  Future<void> start() async {
    if (isConnected || connectionState == HubConnectionState.Connecting) {
      return;
    }

    await _connection.start();
  }

  @protected
  Future<void> stop() async {
    if (connectionState == HubConnectionState.Disconnected) {
      return;
    }

    await _connection.stop();
  }

  @protected
  void onReconnecting(void Function(Exception? error) callback) {
    _connection.onreconnecting(({error}) => callback(error));
  }

  @protected
  void onReconnected(void Function(String? connectionId) callback) {
    _connection.onreconnected(({connectionId}) => callback(connectionId));
  }

  @protected
  void onConnectionClose(void Function(Exception? error) callback) {
    _connection.onclose(({error}) => callback(error));
  }

  @protected
  void on(String methodName, MethodInvocationFunc handler) {
    _eventHandlers
        .putIfAbsent(methodName, () => <MethodInvocationFunc>[])
        .add(handler);
    _connection.on(methodName, handler);
  }

  @protected
  Future<Object?> invoke(String methodName, List<Object>? args) async {
    if (!isConnected) {
      throw Exception('Not connected to the server.');
    }

    return _connection.invoke(methodName, args: args);
  }

  @protected
  void off(String methodName, MethodInvocationFunc? handler) {
    _eventHandlers[methodName]?.remove(handler);
    _connection.off(methodName, method: handler);
  }

  @override
  Future<void> onClose() async {
    await stop();
    super.onClose();
  }
}
