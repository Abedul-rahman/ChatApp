
import 'package:chatapp/Core/ChatService/chat_service.dart' ;
import 'package:chatapp/Core/ChatService/contracts.dart';
import 'package:flutter/widgets.dart' ;
import 'package:get/get.dart';
import 'package:signalr_netcore/signalr_client.dart' as signalr;

class ChatController extends GetxController {
  final _chat = ChatService.to;

  final usernameController = TextEditingController();
  final roomNameController = TextEditingController();
  final roomDescriptionController = TextEditingController();
  final messageController = TextEditingController();
  RxList<ChatRoomDto> get rooms => _chat.rooms;
  RxList<ChatMessageDto> get messages => _chat.messages;
  Rxn<ChatRoomDto> get activeRoom => _chat.activeRoom;
  RxString get currentUsername => _chat.currentUsername;
  ChatRoomDto? get generalRoom => _chat.generalRoom;
  bool get isConnected => _chat.connectionState.value == signalr.ConnectionState.Connected;
  bool isBusy = false;
  final isCompactRoomsView = true.obs;
  final statusText = 'Choose a username to enter chat.'.obs;

  // Read directly from service — no copies
  signalr.ConnectionState get  connectionState => _chat.connectionState.value;

  bool get canSend =>
      isConnected&&
      _chat.activeRoom.value != null &&
      !isBusy &&
      messageController.text.trim().isNotEmpty;

  bool get canCreateRoom =>
      isConnected&& currentUsername.value.isNotEmpty && !isBusy;
  @override
  void onInit() {
    super.onInit();
    messageController.addListener(_refreshUi);

    // React to service connection state changes for status text only
    ever(_chat.connectionState, _onConnectionStateChanged);
  }

  void _onConnectionStateChanged(signalr.ConnectionState state) {
    switch (state) {
      case signalr.ConnectionState.Connecting:
        _setStatus('Reconnecting to chat server...');
      case signalr.ConnectionState.Connected:
        final username = _chat.currentUsername.value;
        _setStatus(username.isEmpty ? 'Reconnected.' : 'Connected as $username');
      case signalr.ConnectionState.Disconnected:
        _setStatus('Connection closed.');
      default:
        break;
    }
    _refreshUi();
  }

  Future<void> connectUser() async {
    final username = usernameController.text.trim();
    if (username.isEmpty) { _setStatus('Choose a username first.'); return; }

    _setStatus(isConnected ? 'Reconnecting to chat...' : 'Connecting to chat...');

    await _runBusy(() async {
      await _chat.connect(username);
      isCompactRoomsView.value = false;
      _setStatus('Connected as ${_chat.currentUsername.value}');
    }, onError: 'An error occurred while connecting. Please try again.');
  }

  Future<void> joinRoom(String roomId) async {
    if (!isConnected) { _setStatus('Enter chat before joining a room.'); return; }

    await _runBusy(() async {
      final result = await _chat.joinRoom(roomId);
      isCompactRoomsView.value = false;
      _setStatus('Joined #${result.room.name}');
    }, onError: 'Could not join that room.');
  }

  Future<void> joinGeneralRoom() async {
    final room = _chat.generalRoom;
    if (room == null) { _setStatus('The general room is not available yet.'); return; }
    await joinRoom(room.id);
  }

  Future<void> createRoom() async {
    final roomName = roomNameController.text.trim();
    if (roomName.isEmpty) { _setStatus('Room name is required.'); return; }
    final description = roomDescriptionController.text.trim();

    await _runBusy(() async {
      await _chat.createRoom(roomName, description.isEmpty ? null : description);
      roomNameController.clear();
      roomDescriptionController.clear();
      isCompactRoomsView.value = false;
      _setStatus('Joined #${_chat.activeRoom.value?.name}');
    }, onError: 'Could not create that room.');
  }

  Future<void> sendMessage() async {
    final content = messageController.text.trim();
    if (content.isEmpty) return;

    await _runBusy(() async {
      await _chat.sendMessage(content);
      messageController.clear();
    }, onError: 'Could not send your message.');
  }

  Future<void> _runBusy(Future<void> Function() action, {required String onError}) async {
    if (isBusy) return;
    isBusy = true;
    _refreshUi();
    await Future<void>.delayed(Duration.zero);
    try {
      await action();
    } catch (_) {
      _setStatus(onError);
    } finally {
      isBusy = false;
      _refreshUi();
    }
  }

  void _setStatus(String value) { statusText.value = value; _refreshUi(); }
  void showCompactRooms() { isCompactRoomsView.value = true; _refreshUi(); }
  void showCompactChat() { isCompactRoomsView.value = false; _refreshUi(); }
  void _refreshUi() => update();

  @override
  void onClose() {
    usernameController.dispose();
    roomNameController.dispose();
    roomDescriptionController.dispose();
    messageController.dispose();
    super.onClose();
  }
}