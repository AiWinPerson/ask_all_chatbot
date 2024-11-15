import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../controller/bottom_bar_controller.dart';
import '../controller/chat_bot_controller.dart';
import '../env/env.dart';
import '../model/chat_bot.dart';
import '../util/enum.dart';

class Chatting extends StatefulWidget {
  const Chatting({super.key,required this.chatBot});
  final ChatBot chatBot;
  @override
  State<Chatting> createState() => _ChattingState();
}

class _ChattingState extends State<Chatting> {
  late List<types.TextMessage> _messages;
  final _user = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final _chatBotUser = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ab');
  late OpenAIChatCompletionChoiceMessageModel systemMessage;
  late OpenAIChatCompletionChoiceMessageModel userMessage;
  List<OpenAIChatCompletionChoiceMessageModel> requestMessages = [];
  late final ChatBot chatBot = ChatBotController.to.chatBots.firstWhere((e) => e.index == widget.chatBot.index);

  @override
  void initState() {
    OpenAI.apiKey = Env.apiKey;
    _loadMessages();
    super.initState();
  }

  void _loadMessages(){
    _messages = chatBot.messages.isEmpty? [] : chatBot.messages;
  }

  Future<void> _sendToGPT(String message)async{
    systemMessage = chatBot.systemMessage!;
    userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [OpenAIChatCompletionChoiceMessageContentItemModel.text(
        message,
      )],
      role: OpenAIChatMessageRole.user,
    );
    requestMessages = [systemMessage,userMessage];
    OpenAIChatCompletionModel chatCompletion = await OpenAI.instance.chat.create(
      model: 'gpt-3.5-turbo',
      messages: requestMessages,
    );
    String text = chatCompletion.choices.first.message.content![0].text.toString();

    _addMessage(types.TextMessage(
      author: _chatBotUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    ));

  }

  void _addMessage(types.TextMessage message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) async{
    types.TextMessage textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );

    _addMessage(textMessage);

    if(chatBot.chatType == ChatType.others){
      await _sendToGPT(message.text);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
                children: [
                  IconButton(onPressed: ()async{
                    ChatBotController.to.changeMessages(widget.chatBot.index, _messages);
                    BottomBarController.to.changeIdx(1);
                    Get.until((route) => route.isFirst,);
                  }, icon: const Icon(Icons.arrow_back_rounded)),
                  Text(chatBot.title,style: const TextStyle(fontSize: 18),),
                ],
            )
            ,),
          Expanded(
            child: Chat(
              messages: _messages,
              onSendPressed: _handleSendPressed,
              user: _user,
              l10n: const ChatL10nKo(),
              theme: const DefaultChatTheme(
                  backgroundColor:Color.fromRGBO(24,24,38,1),
                  inputBackgroundColor: Color.fromRGBO(32,32,51,1),
                  primaryColor: Color.fromRGBO(57,59,79,1),
                  secondaryColor: Color.fromRGBO(48, 45, 77, 1),
                  receivedMessageBodyTextStyle: TextStyle(color: Colors.white),
                  inputTextDecoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
              ),
              showUserAvatars: true,
              avatarBuilder: (author) => const Icon(Icons.person_outline,color: Colors.white,),
            ),
          ),
        ],
      ),
    )
  );




}
