import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/chat_bot_controller.dart';
import '../model/chat_bot.dart';
import '../util/color_set.dart';
import '../widget/message_dialog.dart';

class MakeChatBot extends StatefulWidget {
  const MakeChatBot({super.key});

  @override
  State<MakeChatBot> createState() => _MakeChatBotState();
}

class _MakeChatBotState extends State<MakeChatBot> {
  final TextEditingController title = TextEditingController();
  final TextEditingController chatBotExplain = TextEditingController();

  void showMessage({required String title,required String content,void Function()? onPressed}){
    Get.dialog(MessageDialog(
      title: title,
      content: Text(content),
      onPressed: onPressed?? () {
        Get.back();
      },
    ));
  }

  void onPressedNextBtn(){
    if(title.text.isEmpty || chatBotExplain.text.isEmpty){
      showMessage(
        title: "챗봇 추가 실패!",
        content: "챗봇의 이름과 설명을 작성해주세요."
      );
    }else{
      if(ChatBotController.to.chatBots.where((e) => e.title == title.text).isEmpty){
        ChatBotController.to.addBot(ChatBot(
            index: ChatBotController.to.chatBots.length,
            title: title.text,
            systemMessage: OpenAIChatCompletionChoiceMessageModel(
                role: OpenAIChatMessageRole.system,
                content: [
                  OpenAIChatCompletionChoiceMessageContentItemModel.text(chatBotExplain.text)
                ]
            )
        ));
        showMessage(
            title: "${title.text} 추가 완료",
            content: "${title.text} 봇이 성공적으로 추가 되었습니다.",
            onPressed: () {
              Get.back();
              Get.back();
            },
        );
      }else{
        showMessage(
            title: "챗봇 추가 실패!",
            content: "이미 존재하는 챗봇입니다."
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 5),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: onPressedNextBtn,
                  icon: const Icon(Icons.play_arrow_sharp),
                )
              ),
              SizedBox(
                height: 40,
                child: Row(
                  children: [
                    Expanded(child: TextField(
                      controller: title,
                      decoration: inputDecoration("챗봇의 이름을 작성해주세요.")
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                height: 50,
                child: TextField(
                  controller: chatBotExplain,
                  decoration: inputDecoration("만들 챗봇에 대한 설명을 작성해주세요."),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  InputDecoration inputDecoration(String hint){
    return InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
        hintText: hint,
        hintStyle: const TextStyle(
          color: ColorSet.whiteOpacity600,
        ),
        border: const UnderlineInputBorder(
            borderSide: BorderSide(color: ColorSet.whiteOpacity800)
        ),
        focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: ColorSet.white))
    );
  }

}
