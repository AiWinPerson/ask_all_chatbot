import 'package:dart_openai/dart_openai.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import '../util/enum.dart';

export 'package:dart_openai/dart_openai.dart';

class ChatBot{
  int index;
  String title;
  OpenAIChatCompletionChoiceMessageModel? systemMessage;
  List<types.TextMessage> messages;
  ChatType chatType;

  ChatBot({
    required this.index,
    required this.title,
    this.systemMessage,
    this.messages = const [],
    this.chatType = ChatType.others,
});

}