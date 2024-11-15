import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chat_bot_controller.dart';
import '../util/searching.dart';
import '../widget/chatting_listing_title.dart';

class ChattingListing extends StatefulWidget {
  const ChattingListing({super.key});

  @override
  State<ChattingListing> createState() => _ChattingListingState();
}

class _ChattingListingState extends State<ChattingListing> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
        child: Column(
          children: [
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  const Text("채팅",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                  const Spacer(),
                  IconButton(onPressed: (){
                    Get.to(() => const Searching());
                  }, icon: const Icon(Icons.search),padding: const EdgeInsets.all(5),),
                ],
              ),
            ),
            Expanded(child: Obx(() => ChattingListingTitle(chatBots: ChatBotController.to.chatBots.value,),))
          ],
        ),
      )
    );
  }

}
