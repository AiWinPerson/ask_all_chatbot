import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chat_bot_controller.dart';
import '../util/searching.dart';
import '../widget/friend_avatar_title_list.dart';
import 'make_chat_bot.dart';


class FriendShowing extends StatefulWidget {
  const FriendShowing({super.key});

  @override
  State<FriendShowing> createState() => _FriendShowingState();
}

class _FriendShowingState extends State<FriendShowing> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  const Text("친구",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  const Spacer(),
                  IconButton(onPressed: (){
                    Get.to(() => const Searching());
                  }, icon: const Icon(Icons.search),padding: const EdgeInsets.all(5),),
                  IconButton(onPressed: (){
                    Get.to(() => const MakeChatBot());
                  }, icon: const Icon(Icons.person_add_alt_1),padding: const EdgeInsets.all(5),)
                ],
              ),
            ),
            Expanded(child: Obx(() => FriendAvatarTitleList(
              chatBots: ChatBotController.to.chatBots.value,
            ),)),
          ],
        ),
      )
    );
  }


}
