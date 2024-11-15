import 'package:flutter/material.dart';

extension KeyboardExtension on BuildContext{
  Future<void> unFocus()async{
    if(MediaQuery.of(this).viewInsets.bottom > 0){
      FocusScope.of(this).unfocus();
      await Future.delayed(const Duration(milliseconds: 400));
    }
  }
}