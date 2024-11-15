import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_bar_controller.dart';
import '../controller/chat_bot_controller.dart';
import '../util/color_set.dart';
import 'chatting_listing.dart';
import 'friend_showing.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  void dispose(){
    Get.delete<ChatBotController>();
    Get.delete<BottomBarController>();
    super.dispose();
  }

  void _onPressBottomTap(int idx){
    if(BottomBarController.to.barIdx != idx){
      BottomBarController.to.changeIdx(idx);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Obx(() => IndexedStack(
        index: BottomBarController.to.barIdx,
        children: const [
          FriendShowing(),
          ChattingListing()
        ],
      ),)),
      bottomNavigationBar: Theme(data: ThemeData(
        splashColor: ColorSet.transparent,
        highlightColor: ColorSet.transparent,
        splashFactory: NoSplash.splashFactory
      ), child: Obx(
        () => BottomNavigationBar(
            onTap: (value) => _onPressBottomTap(value),
            selectedItemColor: ColorSet.white,
            unselectedItemColor: ColorSet.whiteOpacity400,
            currentIndex: BottomBarController.to.barIdx,
            backgroundColor: ColorSet.indigo500,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person,),
                label: "친구",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble,),
                label: "대화",
              ),
            ]),
      )),
    );
  }
}
