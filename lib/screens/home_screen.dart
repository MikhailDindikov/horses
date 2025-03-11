import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/models/home_model.dart';
import 'package:horses/screens/analytics_screen.dart';
import 'package:horses/screens/calendar_screen.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_images.dart';
import 'package:horses/utils/app_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _models = [
    (
      AppImages.odd,
      'No hour of life is wasted that is spent in the saddle.',
      'Winston S. Churchill'
    ),
    (AppImages.even, 'In riding a horse, we borrow freedom.', 'Helen Thompson'),
    (
      AppImages.odd,
      "It's always been and always will be the same in the world. The horse does the work and the coachman is tipped.",
      '~Author Unknown'
    ),
    (
      AppImages.even,
      'If you fall off a horse, you get back up. I am not a quitter.',
      'Olivia Wilde'
    ),
    (
      AppImages.odd,
      'The essential joy of being with horses is that it brings us in contact with the rare elements of grace, beauty, spirit and freedom.',
      'Sharon Ralls Lemon'
    ),
    (AppImages.even, 'Horses lend us the wings we lack.', 'Pam Brown'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.to(() => const CalendarScreen());
          },
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(AppIcons.calendar),
          ),
        ),
        centerTitle: true,
        title: Text(
          'Home',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => const AnalyticsScreen());
            },
            child: Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(AppIcons.analytics),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          itemBuilder: (context, index) => HomePageCard(
            data: _models[index],
          ),
          separatorBuilder: (context, index) => const SizedBox(
            height: 12,
          ),
          itemCount: _models.length,
        ),
      ),
    );
  }
}

class HomePageCard extends StatelessWidget {
  final (String, String, String) data;
  const HomePageCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 300,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(
              data.$1,
            ),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(0),
                Colors.black.withOpacity(1),
                Colors.black.withOpacity(1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data.$2,
                style: AppText.h3.copyWith(color: AppColors.white),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data.$3,
                      style: AppText.h6.copyWith(color: AppColors.white),
                    ),
                  ),
                  // const SizedBox(
                  //   width: 8,
                  // ),
                  // SvgPicture.asset(AppIcons.share),
                  // const SizedBox(
                  //   width: 12,
                  // ),
                  // SvgPicture.asset(AppIcons.like),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomeDetailScreen extends StatelessWidget {
  final HomeModel model;
  const HomeDetailScreen({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightYellow,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Get.back();
          },
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              AppIcons.back,
              color: AppColors.white,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          ClipPath(
            clipper: CurvedImage(),
            child: Image.asset(
              model.imgPath,
              height: 350,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24)
                        .copyWith(top: 0),
                child: Column(
                  children: [
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.white,
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Color.fromRGBO(0, 0, 0, 0.2),
                            )
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SvgPicture.asset(AppIcons.autor),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Autor',
                                        style: AppText.footnote
                                            .copyWith(color: AppColors.black),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        model.shortAutor,
                                        style: AppText.h6
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                            Container(
                              width: 1,
                              height: double.infinity,
                              color: const Color.fromRGBO(33, 33, 33, 1),
                            ),
                            const SizedBox(
                              width: 28,
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(AppIcons.timeY),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Time',
                                        style: AppText.footnote
                                            .copyWith(color: AppColors.black),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        model.time,
                                        style: AppText.h6
                                            .copyWith(color: AppColors.black),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      model.title,
                      style: AppText.h2.copyWith(color: AppColors.black),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      model.text,
                      style: AppText.h5.copyWith(color: AppColors.black),
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
    path.lineTo(0, size.height);
    path.quadraticBezierTo(0, size.height - 32, 32, size.height - 32);
    path.lineTo(size.width - 32, size.height - 32);
    path.quadraticBezierTo(
        size.width, size.height - 32, size.width, size.height);

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
