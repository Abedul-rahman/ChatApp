import 'package:chatapp/Core/ChatService/chat_service.dart';
import 'package:chatapp/Core/signalr_service.dart';
import 'package:chatapp/Modules/Chat/chat_controller.dart';
import 'package:get/get.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignalrService>(SignalrService(), permanent: true);
    Get.put<ChatService>(ChatService(), permanent: true);
    Get.lazyPut<ChatController>(
      () => ChatController(),
      fenix: true,
    );
  }
}
