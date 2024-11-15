import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/chat_bot.dart';
import '../util/color_set.dart';
import '../widget/chatting.dart';
import '../widget/person_icon.dart';
import 'name_change.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({
    super.key,
    required this.chatBot,
    this.avatarColor = ColorSet.whiteOpacity800
  });
  final ChatBot chatBot;
  final Color avatarColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: IconButton(onPressed: (){
                  Get.back();
                }, icon: const Icon(Icons.close))
            ),
            const Spacer(),
            SizedBox(
              height: 300,
              child: Column(
                children: [
                  Expanded(
                      flex: 2,
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            PersonIcon(
                              diameter: 80,
                              iconSize: 50,
                              bgColor: avatarColor,
                              personColor: Colors.white
                            ),
                            const SizedBox(height: 15,),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(chatBot.title,style: const TextStyle(fontSize: 18),),
                                ),
                                IconButton(
                                    style: IconButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size.zero,
                                      splashFactory: NoSplash.splashFactory,
                                      highlightColor: ColorSet.transparent,
                                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    padding: EdgeInsets.zero,
                                    onPressed: (){
                                      Get.to(() => NameChange(chatBot: chatBot,));
                                    },
                                    icon: const Icon(Icons.create_outlined,size: 20,)
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                  const Divider(color: ColorSet.whiteOpacity400,thickness: 0.5,height: 2,),
                  Expanded(child: Center(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        Get.to(() => Chatting(chatBot: chatBot,));
                      },
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.chat_bubble),
                          SizedBox(height: 15,),
                          Text("1:1채팅")
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
