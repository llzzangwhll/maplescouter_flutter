import 'package:get/get.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MainController extends GetxController {
  WebViewControllerPlus webViewController = WebViewControllerPlus();
  String url = "https://maplescouter.com";
  bool canPop = true;
}