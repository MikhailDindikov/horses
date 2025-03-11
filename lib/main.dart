import 'package:apphud/apphud.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:horses/controllers/app_bindings.dart';
import 'package:horses/models/checklist_model.dart';
import 'package:horses/screens/main_screen.dart';
import 'package:horses/screens/onboarding_screen.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_utils.dart';
import 'package:horses/utils/notification_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppUtils.initialize();
  if (AppUtils.prefs.getStringList('checklists') == null) {
    await AppUtils.prefs.setStringList(
      'checklists',
      [
        ChecklistModel(
          id: UniqueKey().toString(),
          title: 'Pre-ride checklist',
          iconPath: AppIcons.preRide,
          sections: [
            ChecklistSection(
              title: 'Equipment',
            ),
            ChecklistSection(
              title: 'Horse health',
            ),
            ChecklistSection(
              title: 'Warm-up exercises',
            ),
          ],
        ).toJson(),
        ChecklistModel(
          id: UniqueKey().toString(),
          title: 'Post-ride checklist',
          iconPath: AppIcons.postRide,
          sections: [
            ChecklistSection(
              title: 'Equipment',
            ),
            ChecklistSection(
              title: 'Horse health',
            ),
          ],
        ).toJson(),
      ],
    );
  }
  await Apphud.start(apiKey: 'app_fNF6mvrFjsWJXE4R6p4Q1mZWdcCVmK');
  final showOnboardig = AppUtils.prefs.getBool('showOnboardig') ?? true;
  runApp(HorsingApp(
    showOnboardig: showOnboardig,
  ));
}

class HorsingApp extends StatefulWidget {
  final bool showOnboardig;
  const HorsingApp({super.key, required this.showOnboardig});

  @override
  State<HorsingApp> createState() => _HorsingAppState();
}

class _HorsingAppState extends State<HorsingApp> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarColor: Colors.transparent));

    NotificationService.init();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppBindings(),
      title: 'T-Rider Book',
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: AppBarTheme(surfaceTintColor: Colors.transparent),
      ),
      home:
          widget.showOnboardig ? const OnboardingScreen() : const MainScreen(),
    );
  }
}
