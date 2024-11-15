import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart';
import 'package:get/get.dart';

import '../controller/chat_bot_controller.dart';
import '../model/chat_bot.dart';
import '../widget/chatting_listing_title.dart';
import '../widget/friend_avatar_title_list.dart';
import 'color_set.dart';

class Searching extends StatefulWidget {
  const Searching({super.key});

  @override
  State<Searching> createState() => _SearchingState();
}

class _SearchingState extends State<Searching> {

  String searchKeyword = "";
  Widget noResult = const Center(child: Text("검색된 결과가 없습니다."),);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Column(
            children: [
              _searchInput(),
              Expanded(child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      _tabBar(),
                      Expanded(child: Obx(() {
                        List<ChatBot> chatBots = searchKeyword.isEmpty?
                        ChatBotController.to.chatBots :
                        ChatBotController.to.chatBots.where((e) => e.title.contains(searchKeyword)).toList();
                        List<bool> messages =  List.from(chatBots.map((e) => e.messages.isEmpty).toList());
                        bool messageIsEmpty = !messages.any((e) => e == false);
                        return TabBarView(
                            children: [
                              chatBots.isEmpty? noResult : FriendAvatarTitleList(
                                chatBots: chatBots,
                              ),
                              messageIsEmpty? noResult : ChattingListingTitle(
                                chatBots: chatBots,
                              )
                            ]);
                      },)),
                    ],
                  )
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBar(){
    return const TabBar(
        isScrollable: true,
        overlayColor: WidgetStatePropertyAll(ColorSet.transparent),
        splashFactory: NoSplash.splashFactory,
        dividerColor: ColorSet.whiteOpacity400,
        labelStyle: TextStyle(color: ColorSet.white,fontSize: 17),
        unselectedLabelColor: ColorSet.whiteOpacity400,
        labelPadding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
        indicatorColor: ColorSet.white,
        indicatorSize: TabBarIndicatorSize.tab,
        tabAlignment: TabAlignment.start,
        tabs: [
          Text("친구"),
          Text("채팅방")
        ]
    );
  }

  Widget _searchInput(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
      height: 40,
      decoration: BoxDecoration(
        color: ColorSet.indigo700,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        onChanged: (value){
          searchKeyword = value;
          setState(() {});
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 3,vertical: 2),
          prefixIcon: IconButton(
            icon: const Icon(Icons.arrow_back_rounded,color: ColorSet.whiteOpacity800,),
            onPressed: (){
              Get.back();
            },
          ),
          suffixIcon: searchKeyword.isEmpty? null : IconButton(
            icon: const Icon(Icons.close,color: ColorSet.whiteOpacity800,),
            onPressed: (){
              searchKeyword = "";
              setState(() {});
            },
          )
        ),
      )
    );
  }

}
