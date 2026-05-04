// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'contracts.dart';

class ChatRoomDtoMapper extends ClassMapperBase<ChatRoomDto> {
  ChatRoomDtoMapper._();

  static ChatRoomDtoMapper? _instance;
  static ChatRoomDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatRoomDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ChatRoomDto';

  static String _$id(ChatRoomDto v) => v.id;
  static const Field<ChatRoomDto, String> _f$id = Field('id', _$id);
  static String _$name(ChatRoomDto v) => v.name;
  static const Field<ChatRoomDto, String> _f$name = Field('name', _$name);
  static String? _$description(ChatRoomDto v) => v.description;
  static const Field<ChatRoomDto, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static DateTime _$createdAt(ChatRoomDto v) => v.createdAt;
  static const Field<ChatRoomDto, DateTime> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
  );

  @override
  final MappableFields<ChatRoomDto> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #createdAt: _f$createdAt,
  };

  static ChatRoomDto _instantiate(DecodingData data) {
    return ChatRoomDto(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatRoomDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatRoomDto>(map);
  }

  static ChatRoomDto fromJson(String json) {
    return ensureInitialized().decodeJson<ChatRoomDto>(json);
  }
}

mixin ChatRoomDtoMappable {
  String toJson() {
    return ChatRoomDtoMapper.ensureInitialized().encodeJson<ChatRoomDto>(
      this as ChatRoomDto,
    );
  }

  Map<String, dynamic> toMap() {
    return ChatRoomDtoMapper.ensureInitialized().encodeMap<ChatRoomDto>(
      this as ChatRoomDto,
    );
  }

  ChatRoomDtoCopyWith<ChatRoomDto, ChatRoomDto, ChatRoomDto> get copyWith =>
      _ChatRoomDtoCopyWithImpl<ChatRoomDto, ChatRoomDto>(
        this as ChatRoomDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ChatRoomDtoMapper.ensureInitialized().stringifyValue(
      this as ChatRoomDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatRoomDtoMapper.ensureInitialized().equalsValue(
      this as ChatRoomDto,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatRoomDtoMapper.ensureInitialized().hashValue(this as ChatRoomDto);
  }
}

extension ChatRoomDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatRoomDto, $Out> {
  ChatRoomDtoCopyWith<$R, ChatRoomDto, $Out> get $asChatRoomDto =>
      $base.as((v, t, t2) => _ChatRoomDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChatRoomDtoCopyWith<$R, $In extends ChatRoomDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? description, DateTime? createdAt});
  ChatRoomDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ChatRoomDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatRoomDto, $Out>
    implements ChatRoomDtoCopyWith<$R, ChatRoomDto, $Out> {
  _ChatRoomDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatRoomDto> $mapper =
      ChatRoomDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? name,
    Object? description = $none,
    DateTime? createdAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (name != null) #name: name,
      if (description != $none) #description: description,
      if (createdAt != null) #createdAt: createdAt,
    }),
  );
  @override
  ChatRoomDto $make(CopyWithData data) => ChatRoomDto(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  ChatRoomDtoCopyWith<$R2, ChatRoomDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChatRoomDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ChatMessageDtoMapper extends ClassMapperBase<ChatMessageDto> {
  ChatMessageDtoMapper._();

  static ChatMessageDtoMapper? _instance;
  static ChatMessageDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatMessageDtoMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ChatMessageDto';

  static String _$id(ChatMessageDto v) => v.id;
  static const Field<ChatMessageDto, String> _f$id = Field('id', _$id);
  static String _$roomId(ChatMessageDto v) => v.roomId;
  static const Field<ChatMessageDto, String> _f$roomId = Field(
    'roomId',
    _$roomId,
  );
  static String _$username(ChatMessageDto v) => v.username;
  static const Field<ChatMessageDto, String> _f$username = Field(
    'username',
    _$username,
  );
  static String _$content(ChatMessageDto v) => v.content;
  static const Field<ChatMessageDto, String> _f$content = Field(
    'content',
    _$content,
  );
  static DateTime _$sentAt(ChatMessageDto v) => v.sentAt;
  static const Field<ChatMessageDto, DateTime> _f$sentAt = Field(
    'sentAt',
    _$sentAt,
  );

  @override
  final MappableFields<ChatMessageDto> fields = const {
    #id: _f$id,
    #roomId: _f$roomId,
    #username: _f$username,
    #content: _f$content,
    #sentAt: _f$sentAt,
  };

  static ChatMessageDto _instantiate(DecodingData data) {
    return ChatMessageDto(
      id: data.dec(_f$id),
      roomId: data.dec(_f$roomId),
      username: data.dec(_f$username),
      content: data.dec(_f$content),
      sentAt: data.dec(_f$sentAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatMessageDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatMessageDto>(map);
  }

  static ChatMessageDto fromJson(String json) {
    return ensureInitialized().decodeJson<ChatMessageDto>(json);
  }
}

mixin ChatMessageDtoMappable {
  String toJson() {
    return ChatMessageDtoMapper.ensureInitialized().encodeJson<ChatMessageDto>(
      this as ChatMessageDto,
    );
  }

  Map<String, dynamic> toMap() {
    return ChatMessageDtoMapper.ensureInitialized().encodeMap<ChatMessageDto>(
      this as ChatMessageDto,
    );
  }

  ChatMessageDtoCopyWith<ChatMessageDto, ChatMessageDto, ChatMessageDto>
  get copyWith => _ChatMessageDtoCopyWithImpl<ChatMessageDto, ChatMessageDto>(
    this as ChatMessageDto,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ChatMessageDtoMapper.ensureInitialized().stringifyValue(
      this as ChatMessageDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatMessageDtoMapper.ensureInitialized().equalsValue(
      this as ChatMessageDto,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatMessageDtoMapper.ensureInitialized().hashValue(
      this as ChatMessageDto,
    );
  }
}

extension ChatMessageDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatMessageDto, $Out> {
  ChatMessageDtoCopyWith<$R, ChatMessageDto, $Out> get $asChatMessageDto =>
      $base.as((v, t, t2) => _ChatMessageDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChatMessageDtoCopyWith<$R, $In extends ChatMessageDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? roomId,
    String? username,
    String? content,
    DateTime? sentAt,
  });
  ChatMessageDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatMessageDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatMessageDto, $Out>
    implements ChatMessageDtoCopyWith<$R, ChatMessageDto, $Out> {
  _ChatMessageDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatMessageDto> $mapper =
      ChatMessageDtoMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? roomId,
    String? username,
    String? content,
    DateTime? sentAt,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (roomId != null) #roomId: roomId,
      if (username != null) #username: username,
      if (content != null) #content: content,
      if (sentAt != null) #sentAt: sentAt,
    }),
  );
  @override
  ChatMessageDto $make(CopyWithData data) => ChatMessageDto(
    id: data.get(#id, or: $value.id),
    roomId: data.get(#roomId, or: $value.roomId),
    username: data.get(#username, or: $value.username),
    content: data.get(#content, or: $value.content),
    sentAt: data.get(#sentAt, or: $value.sentAt),
  );

  @override
  ChatMessageDtoCopyWith<$R2, ChatMessageDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChatMessageDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ChatJoinResultDtoMapper extends ClassMapperBase<ChatJoinResultDto> {
  ChatJoinResultDtoMapper._();

  static ChatJoinResultDtoMapper? _instance;
  static ChatJoinResultDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatJoinResultDtoMapper._());
      ChatRoomDtoMapper.ensureInitialized();
      ChatMessageDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChatJoinResultDto';

  static ChatRoomDto _$room(ChatJoinResultDto v) => v.room;
  static const Field<ChatJoinResultDto, ChatRoomDto> _f$room = Field(
    'room',
    _$room,
  );
  static List<ChatMessageDto> _$messages(ChatJoinResultDto v) => v.messages;
  static const Field<ChatJoinResultDto, List<ChatMessageDto>> _f$messages =
      Field('messages', _$messages);

  @override
  final MappableFields<ChatJoinResultDto> fields = const {
    #room: _f$room,
    #messages: _f$messages,
  };

  static ChatJoinResultDto _instantiate(DecodingData data) {
    return ChatJoinResultDto(
      room: data.dec(_f$room),
      messages: data.dec(_f$messages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatJoinResultDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatJoinResultDto>(map);
  }

  static ChatJoinResultDto fromJson(String json) {
    return ensureInitialized().decodeJson<ChatJoinResultDto>(json);
  }
}

mixin ChatJoinResultDtoMappable {
  String toJson() {
    return ChatJoinResultDtoMapper.ensureInitialized()
        .encodeJson<ChatJoinResultDto>(this as ChatJoinResultDto);
  }

  Map<String, dynamic> toMap() {
    return ChatJoinResultDtoMapper.ensureInitialized()
        .encodeMap<ChatJoinResultDto>(this as ChatJoinResultDto);
  }

  ChatJoinResultDtoCopyWith<
    ChatJoinResultDto,
    ChatJoinResultDto,
    ChatJoinResultDto
  >
  get copyWith =>
      _ChatJoinResultDtoCopyWithImpl<ChatJoinResultDto, ChatJoinResultDto>(
        this as ChatJoinResultDto,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ChatJoinResultDtoMapper.ensureInitialized().stringifyValue(
      this as ChatJoinResultDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatJoinResultDtoMapper.ensureInitialized().equalsValue(
      this as ChatJoinResultDto,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatJoinResultDtoMapper.ensureInitialized().hashValue(
      this as ChatJoinResultDto,
    );
  }
}

extension ChatJoinResultDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatJoinResultDto, $Out> {
  ChatJoinResultDtoCopyWith<$R, ChatJoinResultDto, $Out>
  get $asChatJoinResultDto => $base.as(
    (v, t, t2) => _ChatJoinResultDtoCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ChatJoinResultDtoCopyWith<
  $R,
  $In extends ChatJoinResultDto,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ChatRoomDtoCopyWith<$R, ChatRoomDto, ChatRoomDto> get room;
  ListCopyWith<
    $R,
    ChatMessageDto,
    ChatMessageDtoCopyWith<$R, ChatMessageDto, ChatMessageDto>
  >
  get messages;
  $R call({ChatRoomDto? room, List<ChatMessageDto>? messages});
  ChatJoinResultDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatJoinResultDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatJoinResultDto, $Out>
    implements ChatJoinResultDtoCopyWith<$R, ChatJoinResultDto, $Out> {
  _ChatJoinResultDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatJoinResultDto> $mapper =
      ChatJoinResultDtoMapper.ensureInitialized();
  @override
  ChatRoomDtoCopyWith<$R, ChatRoomDto, ChatRoomDto> get room =>
      $value.room.copyWith.$chain((v) => call(room: v));
  @override
  ListCopyWith<
    $R,
    ChatMessageDto,
    ChatMessageDtoCopyWith<$R, ChatMessageDto, ChatMessageDto>
  >
  get messages => ListCopyWith(
    $value.messages,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(messages: v),
  );
  @override
  $R call({ChatRoomDto? room, List<ChatMessageDto>? messages}) => $apply(
    FieldCopyWithData({
      if (room != null) #room: room,
      if (messages != null) #messages: messages,
    }),
  );
  @override
  ChatJoinResultDto $make(CopyWithData data) => ChatJoinResultDto(
    room: data.get(#room, or: $value.room),
    messages: data.get(#messages, or: $value.messages),
  );

  @override
  ChatJoinResultDtoCopyWith<$R2, ChatJoinResultDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChatJoinResultDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ChatSessionDtoMapper extends ClassMapperBase<ChatSessionDto> {
  ChatSessionDtoMapper._();

  static ChatSessionDtoMapper? _instance;
  static ChatSessionDtoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ChatSessionDtoMapper._());
      ChatRoomDtoMapper.ensureInitialized();
      ChatMessageDtoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ChatSessionDto';

  static String _$username(ChatSessionDto v) => v.username;
  static const Field<ChatSessionDto, String> _f$username = Field(
    'username',
    _$username,
  );
  static List<ChatRoomDto> _$rooms(ChatSessionDto v) => v.rooms;
  static const Field<ChatSessionDto, List<ChatRoomDto>> _f$rooms = Field(
    'rooms',
    _$rooms,
  );
  static ChatRoomDto _$activeRoom(ChatSessionDto v) => v.activeRoom;
  static const Field<ChatSessionDto, ChatRoomDto> _f$activeRoom = Field(
    'activeRoom',
    _$activeRoom,
  );
  static List<ChatMessageDto> _$messages(ChatSessionDto v) => v.messages;
  static const Field<ChatSessionDto, List<ChatMessageDto>> _f$messages = Field(
    'messages',
    _$messages,
  );

  @override
  final MappableFields<ChatSessionDto> fields = const {
    #username: _f$username,
    #rooms: _f$rooms,
    #activeRoom: _f$activeRoom,
    #messages: _f$messages,
  };

  static ChatSessionDto _instantiate(DecodingData data) {
    return ChatSessionDto(
      username: data.dec(_f$username),
      rooms: data.dec(_f$rooms),
      activeRoom: data.dec(_f$activeRoom),
      messages: data.dec(_f$messages),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ChatSessionDto fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ChatSessionDto>(map);
  }

  static ChatSessionDto fromJson(String json) {
    return ensureInitialized().decodeJson<ChatSessionDto>(json);
  }
}

mixin ChatSessionDtoMappable {
  String toJson() {
    return ChatSessionDtoMapper.ensureInitialized().encodeJson<ChatSessionDto>(
      this as ChatSessionDto,
    );
  }

  Map<String, dynamic> toMap() {
    return ChatSessionDtoMapper.ensureInitialized().encodeMap<ChatSessionDto>(
      this as ChatSessionDto,
    );
  }

  ChatSessionDtoCopyWith<ChatSessionDto, ChatSessionDto, ChatSessionDto>
  get copyWith => _ChatSessionDtoCopyWithImpl<ChatSessionDto, ChatSessionDto>(
    this as ChatSessionDto,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ChatSessionDtoMapper.ensureInitialized().stringifyValue(
      this as ChatSessionDto,
    );
  }

  @override
  bool operator ==(Object other) {
    return ChatSessionDtoMapper.ensureInitialized().equalsValue(
      this as ChatSessionDto,
      other,
    );
  }

  @override
  int get hashCode {
    return ChatSessionDtoMapper.ensureInitialized().hashValue(
      this as ChatSessionDto,
    );
  }
}

extension ChatSessionDtoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ChatSessionDto, $Out> {
  ChatSessionDtoCopyWith<$R, ChatSessionDto, $Out> get $asChatSessionDto =>
      $base.as((v, t, t2) => _ChatSessionDtoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ChatSessionDtoCopyWith<$R, $In extends ChatSessionDto, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ChatRoomDto,
    ChatRoomDtoCopyWith<$R, ChatRoomDto, ChatRoomDto>
  >
  get rooms;
  ChatRoomDtoCopyWith<$R, ChatRoomDto, ChatRoomDto> get activeRoom;
  ListCopyWith<
    $R,
    ChatMessageDto,
    ChatMessageDtoCopyWith<$R, ChatMessageDto, ChatMessageDto>
  >
  get messages;
  $R call({
    String? username,
    List<ChatRoomDto>? rooms,
    ChatRoomDto? activeRoom,
    List<ChatMessageDto>? messages,
  });
  ChatSessionDtoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ChatSessionDtoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ChatSessionDto, $Out>
    implements ChatSessionDtoCopyWith<$R, ChatSessionDto, $Out> {
  _ChatSessionDtoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ChatSessionDto> $mapper =
      ChatSessionDtoMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ChatRoomDto,
    ChatRoomDtoCopyWith<$R, ChatRoomDto, ChatRoomDto>
  >
  get rooms => ListCopyWith(
    $value.rooms,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(rooms: v),
  );
  @override
  ChatRoomDtoCopyWith<$R, ChatRoomDto, ChatRoomDto> get activeRoom =>
      $value.activeRoom.copyWith.$chain((v) => call(activeRoom: v));
  @override
  ListCopyWith<
    $R,
    ChatMessageDto,
    ChatMessageDtoCopyWith<$R, ChatMessageDto, ChatMessageDto>
  >
  get messages => ListCopyWith(
    $value.messages,
    (v, t) => v.copyWith.$chain(t),
    (v) => call(messages: v),
  );
  @override
  $R call({
    String? username,
    List<ChatRoomDto>? rooms,
    ChatRoomDto? activeRoom,
    List<ChatMessageDto>? messages,
  }) => $apply(
    FieldCopyWithData({
      if (username != null) #username: username,
      if (rooms != null) #rooms: rooms,
      if (activeRoom != null) #activeRoom: activeRoom,
      if (messages != null) #messages: messages,
    }),
  );
  @override
  ChatSessionDto $make(CopyWithData data) => ChatSessionDto(
    username: data.get(#username, or: $value.username),
    rooms: data.get(#rooms, or: $value.rooms),
    activeRoom: data.get(#activeRoom, or: $value.activeRoom),
    messages: data.get(#messages, or: $value.messages),
  );

  @override
  ChatSessionDtoCopyWith<$R2, ChatSessionDto, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ChatSessionDtoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

