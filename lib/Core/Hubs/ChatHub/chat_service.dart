import 'package:chatapp/Core/Hubs/ChatHub/chat_methods.dart';
import 'package:chatapp/Core/Hubs/ChatHub/contracts.dart';
import 'package:chatapp/Core/Hubs/signalr_service.dart';
import 'package:chatapp/Utils/helper.dart';
import 'package:get/get.dart';

class ChatService extends SignalrService  implements ChatMethods {

  final List<Function> _disposers = [];

  final currentUsername = ''.obs;
  final activeRoom = Rxn<ChatRoomDto>();
  final rooms = <ChatRoomDto>[].obs;
  final messages = <ChatMessageDto>[].obs;

  static ChatService get to => Get.find<ChatService>();

  ChatRoomDto? get generalRoom {
    for (final room in rooms) {
      if (room.name.toLowerCase() == 'general') return room;
    }
    return null;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    _wireConnectionState();
    _disposers.add(_onReceiveMessage(_handleIncomingMessage));
    _disposers.add(_onRoomsUpdated(_handleRoomsUpdated));
  }
  @override
  Future<ChatSessionDto> connect(String username) async {
    await super.start();
    final result = await super.invoke(ChatHubMethods.connect, [
      username,
    ]);

    if (result == null) throw Exception('Failed to connect to chat server.');

    final session = ChatSessionDtoMapper.fromMap(Helper.asMap(result));

    currentUsername.value = session.username;
    rooms.assignAll(session.rooms);
    activeRoom.value = session.activeRoom;
    messages.assignAll(_toLocal(session.messages));

    return session;
  }

  @override
  Future<ChatJoinResultDto> joinRoom(String roomId) async {
    final result = await super.invoke(ChatHubMethods.joinRoom, [
      roomId,
    ]);
    if (result == null) throw Exception('Failed to join room.');

    final joinResult = ChatJoinResultDtoMapper.fromMap(Helper.asMap(result));
    activeRoom.value = joinResult.room;

    messages.assignAll(_toLocal(joinResult.messages));

    return joinResult;
  }

  @override
  Future<ChatJoinResultDto> createRoom(
    String roomName,
    String? description,
  ) async {
    final args = <Object>[roomName];
    if (description != null && description.trim().isNotEmpty) {
      args.add(description.trim());
    }

    final result = await super.invoke(
      ChatHubMethods.createRoom,
      args,
    );
    if (result == null) throw Exception('Failed to create room.');

    final joinResult = ChatJoinResultDtoMapper.fromMap(Helper.asMap(result));
    activeRoom.value = joinResult.room;
    messages.assignAll(_toLocal(joinResult.messages));

    return joinResult;
  }

  @override
  Future<void> sendMessage(String content) async {
    await super.invoke(ChatHubMethods.sendMessage, [content]);
  }

  List<ChatMessageDto> _toLocal(List<ChatMessageDto> msgs) {
    return msgs.map((m) => m.copyWith(sentAt: m.sentAt.toLocal())).toList();
  }

  Function _onReceiveMessage(void Function(ChatMessageDto message) callback) {
    void handler(List<Object?>? arguments) {
      final data = arguments?.isNotEmpty == true ? arguments!.first : null;
      if (data is Map) {
        callback(ChatMessageDtoMapper.fromMap(Map<String, dynamic>.from(data)));
      }
    }

    super.on(ChatHubMethods.receiveMessage, handler);
    return () => super.off(ChatHubMethods.receiveMessage, handler);
  }

  Function _onRoomsUpdated(void Function(List<ChatRoomDto> rooms) callback) {
    void handler(List<Object?>? arguments) {
      final data = arguments?.isNotEmpty == true ? arguments!.first : null;

      if (data is List) {
        callback(
          data
              .whereType<Map>()
              .map(
                (room) =>
                    ChatRoomDtoMapper.fromMap(Map<String, dynamic>.from(room)),
              )
              .toList(),
        );
        return;
      }

      callback(const <ChatRoomDto>[]);
    }

    super.on(ChatHubMethods.roomsUpdated, handler);
    return () => super.off(ChatHubMethods.roomsUpdated, handler);
  }


  //set up connection state handlers (reconnecting, reconnected, closed)
  void _wireConnectionState() {
    onReconnecting((_) {
    });
    onReconnected((_) {
    });
    onConnectionClose((_) {
    });
  }

  void _handleIncomingMessage(ChatMessageDto message) {
    final currentRoomId = activeRoom.value?.id;
    if (currentRoomId == null || message.roomId != currentRoomId) return;
    messages.add(message.copyWith(sentAt: message.sentAt.toLocal()));
  }

  void _handleRoomsUpdated(List<ChatRoomDto> updatedRooms) {
    rooms.assignAll(updatedRooms);
    final activeRoomId = activeRoom.value?.id;
    if (activeRoomId == null) return;
    final refreshed = updatedRooms.where((r) => r.id == activeRoomId);
    if (refreshed.isNotEmpty) activeRoom.value = refreshed.first;
  }

  @override
  Future onClose() async {
    for (final dispose in _disposers) {
      dispose();
    }
    await super.onClose();
  }
}
