import 'package:get/get.dart';
import 'package:horses/models/calendar_model.dart';
import 'package:horses/utils/app_utils.dart';

class CalendarController extends GetxController {
  List<CalendarModel> data = [];
  final curDate = DateTime.now().obs;

  void getData() {
    data = AppUtils.getForDate(curDate.value);

    update();
  }
}
