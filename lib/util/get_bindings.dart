import 'package:get/get.dart';

import '../controller/bottom_bar_controller.dart';
import '../controller/chat_bot_controller.dart';

class GetBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(ChatBotController(),permanent: true);
    Get.put(BottomBarController(),permanent: true);
  }
}