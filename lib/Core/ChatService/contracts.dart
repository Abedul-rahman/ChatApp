import 'package:dart_mappable/dart_mappable.dart';

part 'contracts.mapper.dart';

// We use CaseStyle.camelCase to handle 'Id', 'Name', etc. automatically.
// If your JSON is inconsistent, we can add hooks, but this covers 99% of C# backends.
@MappableClass(caseStyle: CaseStyle.camelCase)
class ChatRoomDto with ChatRoomDtoMappable {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;

  ChatRoomDto({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
  });
}

@MappableClass(caseStyle: CaseStyle.camelCase)
class ChatMessageDto with ChatMessageDtoMappable {
  final String id;
  final String roomId;
  final String username;
  final String content;
  final DateTime sentAt;

  ChatMessageDto({
    required this.id,
    required this.roomId,
    required this.username,
    required this.content,
    required this.sentAt,
  });
}

@MappableClass(caseStyle: CaseStyle.camelCase)
class ChatJoinResultDto with ChatJoinResultDtoMappable {
  final ChatRoomDto room;
  final List<ChatMessageDto> messages;

  ChatJoinResultDto({required this.room, required this.messages});
}

@MappableClass(caseStyle: CaseStyle.camelCase)
class ChatSessionDto with ChatSessionDtoMappable {
  final String username;
  final List<ChatRoomDto> rooms;
  final ChatRoomDto activeRoom;
  final List<ChatMessageDto> messages;

  ChatSessionDto({
    required this.username,
    required this.rooms,
    required this.activeRoom,
    required this.messages,
  });
}
class ChatHubMethods {
  static const connect = 'Connect';
  static const joinRoom = 'JoinRoom';
  static const createRoom = 'CreateRoom';
  static const sendMessage = 'SendMessage'; 

  // Server-to-client events
  static const receiveMessage = 'ReceiveMessage';
  static const roomsUpdated = 'RoomsUpdated';
  
  }