import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/screens/main_screen.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_images.dart';
import 'package:horses/utils/app_text.dart';
import 'package:horses/utils/app_utils.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _titles = [
    'Welcome to Your Equestrian Journey',
    'Track Your Progress',
    'Learn Like a Pro',
    'Stay Organized',
  ];

  final _texts = [
    '''Ride like a pro with expert guidance! 
From perfecting your posture to enhancing performance, we’ll lead you every step of the way.
''',
    '''Track your progress with real-time analytic every ride, every lesson, every achievement, all in one place!
''',
    '''Master the art of riding with step-by-step tutorials and expert tips designed to boost your confidence.
''',
    '''Stay on track with our smart calendar and checklist tools—plan, schedule, and hit your riding goals effortlessly!
''',
  ];

  final _buttons = [
    'Start Your Jorney',
    'Check Progress',
    'Explore Training',
    'Get Organized',
  ];

  final _imgs = [
    AppImages.onbarding1,
    AppImages.onbarding2,
    AppImages.onbarding3,
    AppImages.onbarding4,
  ];

  final _curScr = 0.obs;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      if (_curScr.value != _pageController.page!.round()) {
        _curScr.value = _pageController.page!.round();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Obx(
          () => _curScr.value == 0
              ? const SizedBox()
              : GestureDetector(
                  onTap: () {
                    _pageController.jumpToPage(_curScr.value - 1);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      AppIcons.back,
                    ),
                  ),
                ),
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              AppUtils.prefs.setBool('showOnboardig', false);

              Get.offAll(() => const MainScreen());
            },
            child: Text(
              'Skip',
              style: AppText.t3.copyWith(color: AppColors.white),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                _imgs[index],
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0),
                  Color.fromRGBO(0, 0, 0, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 62,
                    ),
                    Text(
                      _titles[index],
                      style: AppText.h1.copyWith(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Text(
                      _texts[index],
                      style: AppText.h2.copyWith(color: AppColors.white),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_curScr.value == 3) {
                          AppUtils.prefs.setBool('showOnboardig', false);

                          Get.offAll(() => const MainScreen());
                        } else {
                          _pageController.jumpToPage(_curScr.value + 1);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.mainYellow,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _buttons[index],
                          style: AppText.buttons.copyWith(
                            color: AppColors.mainDark,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
