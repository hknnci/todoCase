import 'package:get/get.dart';

class HomeController extends GetxController {
  //for bottom navigator
  final RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
