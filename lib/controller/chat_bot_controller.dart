import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../model/chat_bot.dart';
import '../util/enum.dart';

class ChatBotController extends GetxController{
  static ChatBotController to = Get.find<ChatBotController>();

  final RxList<ChatBot> _chatBots = <ChatBot>[
    ChatBot(title: "나",chatType: ChatType.me,index: 0),
  ].obs;

  RxList<ChatBot> get chatBots => _chatBots;

  void addBot(ChatBot bot){
    chatBots.add(bot);
  }

  void changeTitle(int index,String newTitle){
    _chatBots[index].title = newTitle;
    _chatBots.refresh();
  }

  void changeMessages(int index,List<types.TextMessage> newMessages){
    _chatBots[index].messages = newMessages;
    _chatBots.refresh();
  }

}