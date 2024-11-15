import 'package:flutter/material.dart';

import '../model/chat_bot.dart';
import 'chatting_title.dart';

class ChattingListingTitle extends StatelessWidget {
  ChattingListingTitle({super.key,required this.chatBots});
  List<ChatBot> chatBots;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: List.generate(chatBots.length,
                  (index) => chatBots[index].messages.isEmpty?
              const SizedBox()
                  : ChattingTitle(chatBot: chatBots[index],)
          ),
        ),
        );
  }
}
