

import 'package:ask_all_chatbot/util/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'screen/home.dart';
import 'util/get_bindings.dart';

void main() async{
  runApp( GetMaterialApp(
    initialBinding: GetBindings(),
    debugShowCheckedModeBanner: false,
    theme: CustomTheme.dark,
    home: const Home(),
  ));
}


