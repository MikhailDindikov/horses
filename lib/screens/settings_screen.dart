import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/screens/premium_screen.dart';
import 'package:horses/screens/system_screen.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_text.dart';
import 'package:horses/utils/app_utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
        centerTitle: true,
        title: Text(
          'Settings',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(
                    left: 12, top: 11, bottom: 11, right: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromRGBO(237, 238, 243, 1)),
                child: Row(
                  children: [
                    SvgPicture.asset(AppIcons.notificationBl),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Text(
                        'Notification',
                        style: AppText.h4.copyWith(color: AppColors.black),
                      ),
                    ),
                    Obx(
                      () => CupertinoSwitch(
                        value: AppUtils.notifications.value,
                        onChanged: (val) {
                          AppUtils.notifications.value = val;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SystemScreen(screen: 'Terms of Usage'));
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, top: 11, bottom: 11, right: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.terms),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Terms of Usage',
                          style: AppText.h5.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SystemScreen(screen: 'Privacy Policy'));
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, top: 11, bottom: 11, right: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.privacy),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Privacy Policy',
                          style: AppText.h5.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => SystemScreen(screen: 'Support'));
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, top: 11, bottom: 11, right: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.support),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Support',
                          style: AppText.h5.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (!AppUtils.restLoad.value) {
                    AppUtils.restorePurchases();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, top: 11, bottom: 11, right: 15),
                  child: Row(
                    children: [
                      Obx(() => AppUtils.restLoad.value
                          ? CupertinoActivityIndicator(
                              color: AppColors.passive,
                            )
                          : SvgPicture.asset(AppIcons.restore)),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Restore Purchase',
                          style: AppText.h5.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(() => PremiumScreen());
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 12, top: 11, bottom: 11, right: 15),
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.premium),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Premium status',
                          style: AppText.h5.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
