import 'package:chatapp/Core/ChatService/contracts.dart';
import 'package:chatapp/Modules/Chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void _dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  ChatController get controller => Get.find<ChatController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
   
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5DD),
      body: SafeArea(
        child: GetBuilder<ChatController>(
          builder: (_) {
            return Column(
              children: <Widget>[
                _TopBar(tabController: _tabController, controller: controller),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      _ConnectTab(controller: controller),
                      _ChatsTab(controller: controller),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.tabController, required this.controller});

  final TabController tabController;
  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    final isConnected = controller.isConnected;
    final username = controller.currentUsername.value;

    return Container(
      color: const Color(0xFF075E54),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
            child: Row(
              children: <Widget>[
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    (username.isEmpty ? 'C' : username[0]).toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'ChatApp',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        controller.statusText.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.82),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isConnected
                        ? const Color(0xFF128C7E)
                        : Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    isConnected ? 'Online' : 'Offline',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const <Widget>[
              Tab(text: 'Connect'),
              Tab(text: 'Chats'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ConnectTab extends StatelessWidget {
  const _ConnectTab({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF0B6B61), Color(0xFFECE5DD)],
          stops: <double>[0, 0.28],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Welcome ',
                      style: TextStyle(
                        color: Color(0xFF111B21),
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Pick a username, open a session, then jump into your rooms.',
                      style: TextStyle(color: Color(0xFF667781), height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: 52,
                            height: 52,
                            decoration: const BoxDecoration(
                              color: Color(0xFF25D366),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              (controller.currentUsername.value.isEmpty
                                      ? '?'
                                      : controller.currentUsername.value[0])
                                  .toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: TextField(
                              controller: controller.usernameController,
                              enabled: !controller.isBusy,
                              decoration: _inputDecoration(
                                'Username',
                              ),
                              textInputAction: TextInputAction.done,
                              onSubmitted: (_) {
                                _dismissKeyboard();
                                controller.connectUser();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: controller.isBusy
                            ? null
                            : () {
                                _dismissKeyboard();
                                controller.connectUser();
                              },
                        style: _primaryButtonStyle(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (controller.isBusy) ...<Widget>[
                                const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                              ],
                              Text(
                                controller.isBusy
                                    ? (controller.isConnected
                                          ? 'Reconnecting...'
                                          : 'Connecting...')
                                    : (controller.isConnected
                                          ? 'Reconnect'
                                          : 'Enter Chat'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7FBEF),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Session',
                            style: TextStyle(
                              color: Color(0xFF111B21),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            controller.currentUsername.value.isEmpty
                                ? 'No active user yet.'
                                : 'Connected as ${controller.currentUsername.value}',
                            style: const TextStyle(color: Color(0xFF3B4A54)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatsTab extends StatelessWidget {
  const _ChatsTab({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxWidth < 920;

        return Container(
          color: const Color(0xFFECE5DD),
          child: compact
              ? controller.isCompactRoomsView.value
                    ? _CompactRoomsView(controller: controller)
                    : _ChatConversation(controller: controller, isCompact: true)
              : Row(
                  children: <Widget>[
                    SizedBox(
                      width: 340,
                      child: _RoomsRail(controller: controller),
                    ),
                    const VerticalDivider(width: 1, color: Color(0xFFD1D7DB)),
                    Expanded(child: _ChatConversation(controller: controller)),
                  ],
                ),
        );
      },
    );
  }
}

class _RoomsRail extends StatelessWidget {
  const _RoomsRail({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          _RailHeader(controller: controller),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ...controller.rooms.map(
                  (room) => _RoomListTile(
                    room: room,
                    isActive: controller.activeRoom.value?.id == room.id,
                    onTap: controller.isBusy
                        ? null
                        : () => controller.joinRoom(room.id),
                  ),
                ),
                _CreateRoomCard(controller: controller),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompactRoomsView extends StatelessWidget {
  const _CompactRoomsView({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
          child: Row(
            children: <Widget>[
              const CircleAvatar(
                backgroundColor: Color(0xFF25D366),
                child: Icon(Icons.chat_rounded, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Chats',
                      style: TextStyle(
                        color: Color(0xFF111B21),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      controller.isConnected
                          ? '${controller.rooms.length} rooms available'
                          : 'Connect first to load rooms',
                      style: const TextStyle(color: Color(0xFF667781)),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed:
                    controller.generalRoom == null || controller.isBusy
                    ? null
                    : controller.joinGeneralRoom,
                icon: const Icon(Icons.campaign_rounded),
                color: const Color(0xFF075E54),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 16),
            children: <Widget>[
              if (controller.rooms.isEmpty)
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 24, 20, 12),
                  child: Text(
                    'No rooms yet. Create one below after you connect.',
                    style: TextStyle(
                      color: Color(0xFF667781),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ...controller.rooms.map(
                (room) => _RoomListTile(
                  room: room,
                  isActive: controller.activeRoom.value?.id == room.id,
                  onTap: controller.isBusy
                      ? null
                      : () => controller.joinRoom(room.id),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: _CreateRoomCard(controller: controller),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RailHeader extends StatelessWidget {
  const _RailHeader({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          const CircleAvatar(
            backgroundColor: Color(0xFF25D366),
            child: Icon(Icons.forum_rounded, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Rooms',
                  style: TextStyle(
                    color: Color(0xFF111B21),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  '${controller.rooms.length} available',
                  style: const TextStyle(color: Color(0xFF667781)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: controller.generalRoom == null || controller.isBusy
                ? null
                : controller.joinGeneralRoom,
            icon: const Icon(Icons.campaign_rounded),
            color: const Color(0xFF075E54),
          ),
        ],
      ),
    );
  }
}

class _RoomListTile extends StatelessWidget {
  const _RoomListTile({
    required this.room,
    required this.isActive,
    required this.onTap,
  });

  final ChatRoomDto room;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? const Color(0xFFE9F5F3) : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: isActive
                    ? const Color(0xFF128C7E)
                    : const Color(0xFF25D366),
                child: Text(
                  room.name.isEmpty ? '#' : room.name[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '# ${room.name}',
                      style: const TextStyle(
                        color: Color(0xFF111B21),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      room.description ?? 'Open room',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0xFF667781)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CreateRoomCard extends StatelessWidget {
  const _CreateRoomCard({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Create a room',
            style: TextStyle(
              color: Color(0xFF111B21),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: controller.roomNameController,
            decoration: _inputDecoration('Room name', hint: 'design'),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller.roomDescriptionController,
            decoration: _inputDecoration(
              'Description',
            ),
            minLines: 2,
            maxLines: 3,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: controller.canCreateRoom
                  ? controller.createRoom
                  : null,
              style: _primaryButtonStyle(),
              child: const Text('Create and join'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatConversation extends StatelessWidget {
  const _ChatConversation({required this.controller, this.isCompact = false});

  final ChatController controller;
  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    final activeRoom = controller.activeRoom.value;

    return Column(
      children: <Widget>[
        Container(
          color: const Color(0xFFF0F2F5),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          child: Row(
            children: <Widget>[
              if (isCompact)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: IconButton(
                    onPressed: controller.showCompactRooms,
                    icon: const Icon(Icons.arrow_back_rounded),
                    color: const Color(0xFF111B21),
                  ),
                ),
              CircleAvatar(
                backgroundColor: const Color(0xFF25D366),
                child: Text(
                  activeRoom == null ? '#' : activeRoom.name[0].toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      activeRoom == null
                          ? 'No room selected'
                          : '# ${activeRoom.name}',
                      style: const TextStyle(
                        color: Color(0xFF111B21),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      activeRoom?.description ??
                          'Choose or create a room to start chatting',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Color(0xFF667781)),
                    ),
                  ],
                ),
              ),
              if (isCompact)
                IconButton(
                  onPressed: controller.showCompactRooms,
                  icon: const Icon(Icons.forum_outlined),
                  color: const Color(0xFF075E54),
                ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(color: Color(0xFFE5DDD5)),
            child: controller.messages.isEmpty
                ? const Center(
                    child: Text(
                      'No messages yet.',
                      style: TextStyle(
                        color: Color(0xFF667781),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.messages.length,
                    itemBuilder: (context, index) {
                      final message = controller.messages[index];
                      return _MessageBubble(
                        message: message,
                        isMine:
                            message.username ==
                            controller.currentUsername.value,
                      );
                    },
                  ),
          ),
        ),
        Container(
          color: const Color(0xFFF0F2F5),
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: controller.messageController,
                  decoration: _inputDecoration(
                    'Message',
                    hint: 'Type a message',
                  ),
                  minLines: 1,
                  maxLines: 4,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) {
                    _dismissKeyboard();
                    controller.sendMessage();
                  },
                ),
              ),
              const SizedBox(width: 10),
              Material(
                color: controller.canSend
                    ? const Color(0xFF128C7E)
                    : const Color(0xFFB7C6C9),
                shape: const CircleBorder(),
                child: IconButton(
                  onPressed: controller.canSend
                      ? () {
                          _dismissKeyboard();
                          controller.sendMessage();
                        }
                      : null,
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.isMine});

  final ChatMessageDto message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 420),
        decoration: BoxDecoration(
          color: isMine ? const Color(0xFFD9FDD3) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(14),
            topRight: const Radius.circular(14),
            bottomLeft: Radius.circular(isMine ? 14 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 14),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 4,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: isMine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.username,
              style: const TextStyle(
                color: Color(0xFF075E54),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message.content,
              style: const TextStyle(color: Color(0xFF111B21), height: 1.4),
            ),
            const SizedBox(height: 6),
            Text(
              _formatTime(message.sentAt),
              style: const TextStyle(color: Color(0xFF667781), fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime value) {
    final hour = value.hour % 12 == 0 ? 12 : value.hour % 12;
    final minute = value.minute.toString().padLeft(2, '0');
    final suffix = value.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $suffix';
  }
}

InputDecoration _inputDecoration(String label, {String? hint}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(22),
      borderSide: const BorderSide(color: Color(0xFF25D366), width: 1.3),
    ),
  );
}

ButtonStyle _primaryButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: const Color(0xFF128C7E),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
  );
}
