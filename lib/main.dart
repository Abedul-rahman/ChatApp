import 'package:chatapp/Utils/constants.dart';
import 'package:chatapp/Modules/Chat/chat_bindings.dart';
import 'package:chatapp/Modules/Chat/screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      initialBinding: ChatBinding(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0F766E),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF6EFE5),
        useMaterial3: true,
      ),
      home: const ChatScreen(),
    );
  }
}
