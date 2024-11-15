import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/chat_bot.dart';
import '../screen/profile_detail.dart';
import '../util/color_set.dart';
import '../util/enum.dart';
import 'avatar_title.dart';

class FriendAvatarTitleList extends StatelessWidget {
  FriendAvatarTitleList({super.key,required this.chatBots});
  List<ChatBot> chatBots;

  void onPressProfile({required ChatBot chatBot,Color avatarColor = ColorSet.whiteOpacity800}){
    Get.to(() => ProfileDetail(chatBot: chatBot,avatarColor: avatarColor,),
        transition: Transition.downToUp);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            children: List.generate(chatBots.length,
                  (index) => chatBots[index].chatType == ChatType.others? AvatarTitle(
                  title: chatBots[index].title,
                  bgColor: ColorSet.mauve300,
                  onTap: (){
                    onPressProfile(chatBot: chatBots[index],avatarColor: ColorSet.mauve300);
                  }
              ) : AvatarTitle(
                  title: chatBots[index].title,
                  onTap: (){
                    onPressProfile(chatBot: chatBots[index],);
                  }
              ),
            )
        )
    );
  }
}
