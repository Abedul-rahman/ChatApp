import 'package:chatapp/Core/Hubs/ChatHub/contracts.dart';

abstract class ChatMethods {
  Future<ChatSessionDto> connect(String username);

  Future<ChatJoinResultDto> joinRoom(String roomId);

  Future<ChatJoinResultDto> createRoom(String roomName, String? description);

  Future<void> sendMessage(String content);
}
