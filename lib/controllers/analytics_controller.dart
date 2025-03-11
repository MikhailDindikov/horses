import 'package:get/get.dart';
import 'package:horses/utils/app_utils.dart';

class AnalyticsController extends GetxController {
  List<double> times = [0, 0, 0, 0, 0, 0, 0];

  String get hoursSum => times.reduce((a, b) => a + b).toStringAsFixed(1);

  double get avgTime => times.reduce((a, b) => a + b) / 7;

  int get days => times.where((a) => a != 0).length;

  void init() {
    times = AppUtils.calculateDurationsForCurrentWeek();

    update();
  }
}
