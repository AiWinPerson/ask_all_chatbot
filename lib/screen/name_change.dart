import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chat_bot_controller.dart';
import '../model/chat_bot.dart';
import '../util/color_set.dart';
import '../util/keyboard_extension.dart';

class NameChange extends StatelessWidget {
  NameChange({super.key,required this.chatBot});
  final ChatBot chatBot;
  late final TextEditingController textEditingController = TextEditingController(text: chatBot.title);

  void _goBack(BuildContext context)async{
    await context.unFocus();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 40,
              child: Row(
                children: [
                  IconButton(onPressed: ()async{
                    _goBack(context);
                  }, icon: const Icon(Icons.arrow_back_rounded)),
                  const Text("이름 편집",style: TextStyle(fontSize: 17),),
                  const Spacer(),
                  TextButton(onPressed: (){
                    ChatBotController.to.changeTitle(chatBot.index, textEditingController.text);
                    _goBack(context);
                  }, child: const Text("확인",style: TextStyle(color: ColorSet.white,fontSize: 17),)),
                ],
              ),
            ),
            Expanded(child: Center(
              child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: textEditingController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorSet.white),
                      ),
                      border: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorSet.whiteOpacity800),
                      ),
                      enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: ColorSet.whiteOpacity800),
                      ),
                      suffix: IconButton(
                          onPressed: (){
                            textEditingController.clear();
                          },
                          icon: const Icon(Icons.close,size: 20,)
                      )
                    ),
                  )
              ),
            ))
          ],
        ),
      ),
    );
  }
}
