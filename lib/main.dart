import 'package:flutter/material.dart';
import 'package:flutter_web/views/layout_template/layout_template.dart';
import 'package:get/get.dart';

import 'controllers/chat_controller.dart';
import 'controllers/login_controller.dart';
import 'locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    loginController.setUser();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GMS',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.black54),
        ),
        primarySwatch: Colors.blue,
        // 웹에서 실행하면 오류 메시지 발생
        // textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      ),
      home: LayoutTemplate(),
    );
  }
}
