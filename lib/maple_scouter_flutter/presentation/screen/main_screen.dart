import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maplescouter_flutter/maple_scouter_flutter/presentation/controller/main_controller.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class MainScreen extends GetView<MainController> {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (await controller.webViewController.canGoBack()) {
          // WebView 에서 이전 스택이 있으면 뒤로가기 시 스택 제거
          controller.webViewController.goBack();
        } else {
          // 스택이 없는 경우 앱 종료
          if (Platform.isAndroid) {
            SystemNavigator.pop();
          } else {
            exit(0);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Obx(
            () => Stack(
              children: [
                Container(
                  color: Colors.white,
                  child: WebViewWidget(
                    controller:
                        controller.webViewController
                          ..loadRequest(Uri.parse(controller.url))
                          ..setJavaScriptMode(JavaScriptMode.unrestricted)
                          ..enableZoom(false)
                          ..setNavigationDelegate(
                            NavigationDelegate(
                              /// 페이지 로딩 시작
                              onPageStarted: (url) {
                                controller.isLoading.value = true;
                              },

                              /// 페이지 로딩 끝
                              onHttpAuthRequest: (request) {
                                controller.isLoading.value = false;
                              },

                              /// 에러 발생 시
                              onWebResourceError: (error) {
                                controller.isLoading.value = false;
                              },
                            ),
                          ),
                  ),
                ),
                Visibility(
                  visible: !controller.isLoading.value,
                  child: Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.deepPurple,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
