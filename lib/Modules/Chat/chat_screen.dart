import 'package:chatapp/Core/ChatService/contracts.dart';
import 'package:chatapp/Modules/Chat/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends GetView<ChatController> {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF6EFE5),
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFFFFF6EA),
              Color(0xFFF4EBE2),
              Color(0xFFEFE5D9),
            ],
          ),
        ),
        child: SafeArea(
          child: GetBuilder<ChatController>(
            builder: (_) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 980;

                  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: compact
                        ? Column(
                            children: <Widget>[
                              _StatusBanner(controller: controller),
                              const SizedBox(height: 16),
                              Expanded(
                                child: ListView(
                                  children: <Widget>[
                                    _SidebarCard(
                                      theme: theme,
                                      controller: controller,
                                    ),
                                    const SizedBox(height: 16),
                                    SizedBox(
                                      height: 520,
                                      child: _ChatPanel(controller: controller),
                                    ),
                                    const SizedBox(height: 16),
                                    _RoomsPanel(controller: controller),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              _StatusBanner(controller: controller),
                              const SizedBox(height: 16),
                              Expanded(
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 280,
                                      child: _SidebarCard(
                                        theme: theme,
                                        controller: controller,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: _ChatPanel(controller: controller),
                                    ),
                                    const SizedBox(width: 16),
                                    SizedBox(
                                      width: 320,
                                      child: _RoomsPanel(
                                        controller: controller,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _StatusBanner extends StatelessWidget {
  const _StatusBanner({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    final connected = controller.isConnected;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x1F6C4628)),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: connected
                  ? const Color(0xFF0F766E)
                  : const Color(0xFFC0841D),
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              controller.statusText.value,
              style: const TextStyle(
                color: Color(0xFF796557),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarCard extends StatelessWidget {
  const _SidebarCard({required this.theme, required this.controller});

  final ThemeData theme;
  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    final currentUser = controller.currentUsername.value;

    return _Panel(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Chat App',
              style: theme.textTheme.headlineMedium?.copyWith(
                color: const Color(0xFF2F241D),
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Mirror the web chat flow with live rooms and messages.',
              style: TextStyle(color: Color(0xFF796557), height: 1.5),
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFAF3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x1F6C4628)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 56,
                    height: 56,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: const LinearGradient(
                        colors: <Color>[Color(0xFF0F766E), Color(0xFF1AA095)],
                      ),
                    ),
                    child: Text(
                      (currentUser.isEmpty ? '?' : currentUser[0])
                          .toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: controller.usernameController,
                    decoration: _inputDecoration('Username'),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => controller.connectUser(),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: controller.isBusy
                          ? null
                          : controller.connectUser,
                      style: _filledButtonStyle(),
                      child: Text(
                        controller.isConnected
                            ? 'Reconnect Session'
                            : 'Enter Chat',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currentUser.isEmpty
                        ? 'No user connected yet'
                        : 'Connected as $currentUser',
                    style: const TextStyle(
                      color: Color(0xFF796557),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFAF3),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0x1F6C4628)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Quick access',
                    style: TextStyle(
                      color: Color(0xFF2F241D),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed:
                          controller.generalRoom == null ||
                              controller.isBusy
                          ? null
                          : controller.joinGeneralRoom,
                      style: _outlinedButtonStyle(),
                      child: const Text('Join #general'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatPanel extends StatelessWidget {
  const _ChatPanel({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    final room = controller.activeRoom.value;
    final messages = controller.messages;

    return _Panel(
      padding: EdgeInsets.zero,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(22),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFAF3),
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        room == null ? 'Select a room' : '# ${room.name}',
                        style: const TextStyle(
                          color: Color(0xFF2F241D),
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        room?.description ?? 'Room conversation',
                        style: const TextStyle(
                          color: Color(0xFF796557),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1F0F766E),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    '${messages.length} message${messages.length == 1 ? '' : 's'}',
                    style: const TextStyle(
                      color: Color(0xFF0B5E58),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: messages.isEmpty
                  ? const Center(
                      child: Text(
                        'Messages will appear here once you join a room.',
                        style: TextStyle(color: Color(0xFF796557)),
                      ),
                    )
                  : ListView.separated(
                      reverse: false,
                      itemCount: messages.length,
                      separatorBuilder: (_, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        final isMine =
                            message.username ==
                            controller.currentUsername.value;
                        return _MessageBubble(message: message, isMine: isMine);
                      },
                    ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFFFFFAF3),
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    decoration: _inputDecoration('Write a message'),
                    minLines: 1,
                    maxLines: 4,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => controller.sendMessage(),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: controller.canSend ? controller.sendMessage : null,
                  style: _filledButtonStyle(),
                  child: const Text('Send'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomsPanel extends StatelessWidget {
  const _RoomsPanel({required this.controller});

  final ChatController controller;

  @override
  Widget build(BuildContext context) {
    final activeRoomId = controller.activeRoom.value?.id;

    return _Panel(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Rooms',
              style: TextStyle(
                color: Color(0xFF2F241D),
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            if (controller.rooms.isEmpty)
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  'No rooms available yet.',
                  style: TextStyle(color: Color(0xFF796557)),
                ),
              )
            else
              ...controller.rooms.map(
                (room) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _RoomTile(
                    room: room,
                    isActive: room.id == activeRoomId,
                    onTap: controller.isBusy
                        ? null
                        : () => controller.joinRoom(room.id),
                  ),
                ),
              ),
            const SizedBox(height: 14),
            const Divider(color: Color(0x1F6C4628)),
            const SizedBox(height: 14),
            const Text(
              'Create room',
              style: TextStyle(
                color: Color(0xFF2F241D),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.roomNameController,
              decoration: _inputDecoration('Room name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller.roomDescriptionController,
              decoration: _inputDecoration('Description'),
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
                style: _filledButtonStyle(),
                child: const Text('Create and join'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoomTile extends StatelessWidget {
  const _RoomTile({
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
      color: isActive ? const Color(0x1F0F766E) : const Color(0xFFFFFAF3),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: isActive
                  ? const Color(0xFF0F766E)
                  : const Color(0x1F6C4628),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '# ${room.name}',
                style: TextStyle(
                  color: isActive
                      ? const Color(0xFF0B5E58)
                      : const Color(0xFF2F241D),
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                room.description ?? 'Open room',
                style: const TextStyle(color: Color(0xFF796557), height: 1.4),
              ),
            ],
          ),
        ),
      ),
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
        constraints: const BoxConstraints(maxWidth: 420),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isMine ? const Color(0xFF0F766E) : const Color(0xFFFFFAF3),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isMine ? const Color(0xFF0F766E) : const Color(0x1F6C4628),
          ),
        ),
        child: Column(
          crossAxisAlignment: isMine
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.username,
              style: TextStyle(
                color: isMine ? Colors.white70 : const Color(0xFF796557),
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              message.content,
              style: TextStyle(
                color: isMine ? Colors.white : const Color(0xFF2F241D),
                height: 1.45,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formatTime(message.sentAt),
              style: TextStyle(
                color: isMine ? Colors.white70 : const Color(0xFF796557),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
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

class _Panel extends StatelessWidget {
  const _Panel({required this.child, this.padding = const EdgeInsets.all(20)});

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.82),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0x1F6C4628)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x244F3825),
            blurRadius: 30,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: child,
    );
  }
}

InputDecoration _inputDecoration(String label) {
  return InputDecoration(
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0x1F6C4628)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0x1F6C4628)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF0F766E), width: 1.4),
    ),
  );
}

ButtonStyle _filledButtonStyle() {
  return FilledButton.styleFrom(
    backgroundColor: const Color(0xFF0F766E),
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}

ButtonStyle _outlinedButtonStyle() {
  return OutlinedButton.styleFrom(
    foregroundColor: const Color(0xFF2F241D),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
    side: const BorderSide(color: Color(0x1F6C4628)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
