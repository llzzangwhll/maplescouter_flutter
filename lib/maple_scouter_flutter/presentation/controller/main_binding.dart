import 'package:get/get.dart';
import 'package:maplescouter_flutter/maple_scouter_flutter/presentation/controller/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
  }
}