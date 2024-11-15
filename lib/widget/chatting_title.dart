import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/chat_bot.dart';
import '../util/color_set.dart';
import '../util/enum.dart';
import 'chatting.dart';
import 'person_icon.dart';

class ChattingTitle extends StatelessWidget {
  ChattingTitle({super.key,required this.chatBot});
  ChatBot chatBot;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        Get.to(() => Chatting(chatBot: chatBot));
      },
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            PersonIcon(
              diameter: 45,
              bgColor: chatBot.chatType == ChatType.me? ColorSet.whiteOpacity600 : ColorSet.mauve300,
            ),
            const SizedBox(width: 15,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: Text(chatBot.title,style: const TextStyle(fontSize: 17),),
                ),
                Expanded(child: Text(chatBot.messages.first.text,style: const TextStyle(fontSize: 17,color: ColorSet.whiteOpacity400,overflow: TextOverflow.ellipsis),)),
              ],
            )),
            Text(DateFormat("HH:mm").format(DateTime.fromMillisecondsSinceEpoch(chatBot.messages.first.createdAt!)),style: const TextStyle(fontSize: 13,color: ColorSet.whiteOpacity400),),
          ],
        ),
      ),
    );
  }
}
