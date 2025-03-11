import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_text.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SystemScreen extends StatefulWidget {
  final String screen;
  const SystemScreen({super.key, required this.screen});

  @override
  State<SystemScreen> createState() => _SystemScreenState();
}

class _SystemScreenState extends State<SystemScreen> {
  late WebViewController _controllerSys;

  @override
  void initState() {
    String type = '';
    if (widget.screen == 'Privacy Policy') {
      type =
          'https://sites.google.com/view/wilhelmrogala/support-form/privacy-policy';
    } else if (widget.screen == 'Terms of Usage') {
      type =
          'https://sites.google.com/view/wilhelmrogala/support-form/terms-conditions';
    } else {
      type = 'https://sites.google.com/view/wilhelmrogala/support-form';
    }

    _controllerSys = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(type));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(247, 247, 247, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: Get.back,
                      child: Container(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          AppIcons.back,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.screen,
                      textAlign: TextAlign.center,
                      style: AppText.h2.copyWith(color: AppColors.black),
                    ),
                  ),
                  Opacity(
                    opacity: 0,
                    child: IgnorePointer(
                      child: Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: Get.back,
                          child: Container(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppIcons.back,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: WebViewWidget(
                  controller: _controllerSys,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
