import 'package:get/get.dart';
import 'package:maplescouter_flutter/maple_scouter_flutter/presentation/controller/main_binding.dart';
import 'package:maplescouter_flutter/maple_scouter_flutter/presentation/screen/main_screen.dart';

class PageInfo {
  static const main = '/main';

  static final List<GetPage> appNavigation = [
    GetPage(name: main, page: () => const MainScreen(), binding: MainBinding())
  ];
}