import 'package:get/get.dart';
import 'package:horses/controllers/analytics_controller.dart';
import 'package:horses/controllers/calendar_controller.dart';
import 'package:horses/controllers/checklist_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AnalyticsController());
    Get.put(CalendarController());
    Get.put(ChecklistController());
  }
}
