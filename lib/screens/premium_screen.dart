import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_images.dart';
import 'package:horses/utils/app_text.dart';
import 'package:horses/utils/app_utils.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: Get.back,
            child: Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                AppIcons.back,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: CurvedImage(),
            child: Image.asset(
              AppImages.prem,
              height: 380,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      'Unlock the Full Equestrian Experience',
                      style: AppText.h2.copyWith(color: AppColors.black),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Get exclusive access to premium features and insights.',
                      style: AppText.h6.copyWith(color: AppColors.black),
                      textAlign: TextAlign.center,
                    ),
                    const Expanded(child: SizedBox()),
                    Text(
                      'Full access for just 0.99\$/month',
                      style: AppText.h6.copyWith(color: AppColors.black),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (!AppUtils.premLoad.value) {
                          AppUtils.purchase();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 22),
                        decoration: BoxDecoration(
                          color: AppColors.mainYellow,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.center,
                        child: Obx(
                          () => AppUtils.premLoad.value
                              ? CupertinoActivityIndicator()
                              : Text(
                                  AppUtils.prem.value
                                      ? 'Premium Activated'
                                      : 'Activate Premium',
                                  style: AppText.buttons
                                      .copyWith(color: AppColors.black),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Obx(
                      () => AppUtils.prem.value
                          ? SizedBox()
                          : GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Get.back();
                              },
                              child: Text(
                                'Remind me later',
                                style: AppText.h5
                                    .copyWith(color: AppColors.passive),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurvedImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - 69);
    path.quadraticBezierTo(0, size.height, size.width / 2, size.height);
    path.moveTo(size.width / 2, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 69);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
