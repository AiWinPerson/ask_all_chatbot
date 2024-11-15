import 'package:get/get.dart';

class BottomBarController extends GetxController{
  static BottomBarController to = Get.find<BottomBarController>();
  final RxInt _barIdx = 0.obs;

  int get barIdx => _barIdx.value;

  void changeIdx(int index){
    _barIdx.value = index;
  }
}