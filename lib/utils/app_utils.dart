import 'dart:convert';

import 'package:apphud/apphud.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:horses/controllers/calendar_controller.dart';
import 'package:horses/models/calendar_model.dart';
import 'package:horses/models/checklist_model.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/notification_util.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUtils {
  static late final SharedPreferences _preferences;

  static SharedPreferences get prefs => _preferences;
  static late RxBool prem;
  static late RxBool notifications;
  static RxBool premLoad = false.obs;
  static RxBool restLoad = false.obs;

  static Future<void> initialize() async {
    _preferences = await SharedPreferences.getInstance();
    notifications = (AppUtils.prefs.getBool('notifications') ?? false).obs;
    final lastAct =
        DateTime.tryParse(AppUtils.prefs.getString('lastAct').toString());
    if (lastAct == null) {
      AppUtils.prefs.setString('lastAct', DateTime.now().toString());
    } else {
      final now = DateTime.now();
      if (now.year != lastAct.year ||
          now.month != lastAct.month ||
          now.day != lastAct.day) {
        final models = AppUtils.getChecklists();
        for (final model in models) {
          for (final section in model.sections) {
            section.isActive = false;
          }
        }
        AppUtils.setChecklists(models);
      }
    }
    prem = (AppUtils.prefs.getBool('prem') ?? false).obs;

    return;
  }

  static Future<bool> createNotifications(CalendarModel model, DateTime not) async {
    final permission = await NotificationService.requestPermissions();
    if (permission != true) {
      return false;
    }

    NotificationService.createScheduledNotification(
      id: model.hashCode,
      title: 'Training',
      body:
          'You have a ${model.title} training at ${model.date.year}.${model.date.month}.${model.date.day} ${DateFormat('hh:mm a').format(model.start)}.',
      showAt: model.date.copyWith(hour: not.hour, minute: not.minute),
    );

    return true;
  }

  static Future<void> purchase() async {
    premLoad.value = true;
    final result = await Apphud.purchase(productId: 'premium');

    premLoad.value = false;
    if (result.error == null) {
      prem.value = true;
      AppUtils.prefs.setBool('prem', true);

      Get.showSnackbar(GetSnackBar(
        duration: 2.seconds,
        backgroundColor: AppColors.mainYellow,
        messageText: const Text(
          'Succeesful!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ));
    } else {
      Get.showSnackbar(GetSnackBar(
        duration: 2.seconds,
        backgroundColor: AppColors.mainYellow,
        messageText: const Text(
          'Some error :(',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ));
    }
  }

  static Future<void> restorePurchases() async {
    restLoad.value = true;
    final items = await Apphud.restorePurchases();
    restLoad.value = false;
    if (items.purchases.isNotEmpty) {
      final ids = items.purchases.map((e) => e.productId).toList();
      if (ids.contains('premium')) {
        prem.value = true;
        AppUtils.prefs.setBool('prem', true);
      } else {
        Get.showSnackbar(GetSnackBar(
          duration: 2.seconds,
          backgroundColor: AppColors.mainYellow,
          messageText: const Text(
            'No purchases found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
        ));
      }
    } else {
      Get.showSnackbar(GetSnackBar(
        duration: 2.seconds,
        backgroundColor: AppColors.mainYellow,
        messageText: const Text(
          'No purchases found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ));
    }
  }

  static List<ChecklistModel> getChecklists() {
    final raw = prefs.getStringList('checklists');
    return (raw ?? [])
        .map((e) => ChecklistModel.fromJson(json.decode(e)))
        .toList();
  }

  static Future<void> setChecklists(List<ChecklistModel> models) async {
    await prefs.setStringList(
        'checklists', models.map((e) => e.toJson()).toList());
  }

  static List<String> getRawCalendars() {
    return prefs.getStringList('calendars') ?? [];
  }

  static Future<void> saveCalendars(
    CalendarModel model,
    DateTime? notifDate,
    int count,
  ) async {
    final List<String> models = [];
    CalendarModel curModel = model;
    for (int i = 0; i < count; i++) {
      models.add(curModel.toJson());
      if (notifDate != null) {
        createNotifications(curModel, notifDate);
      }
      curModel = curModel.copyWith(curModel.date.add(Duration(days: 1)));
      
    }

    final allModels = getRawCalendars();
    allModels.addAll(models);

    await prefs.setStringList('calendars', allModels);
    Get.find<CalendarController>().getData();
  }

  static List<CalendarModel> getForDate(DateTime date) {
    final models = (prefs.getStringList('calendars') ?? [])
        .map((e) => CalendarModel.fromJson(json.decode(e)))
        .toList();

    return models
        .where((e) =>
            e.date.year == date.year &&
            e.date.month == date.month &&
            e.date.day == date.day)
        .toList();
  }

  static List<CalendarModel> getAll() {
    final models = (prefs.getStringList('calendars') ?? [])
        .map((e) => CalendarModel.fromJson(json.decode(e)))
        .toList();

    return models;
  }

  static List<CalendarModel> getForMonth(DateTime date) {
    final models = (prefs.getStringList('calendars') ?? [])
        .map((e) => CalendarModel.fromJson(json.decode(e)))
        .toList();

    return models
        .where((e) => e.date.year == date.year && e.date.month == date.month)
        .toList();
  }

  static List<CalendarModel> getCurWeek() {
    final models = (prefs.getStringList('calendars') ?? [])
        .map((e) => CalendarModel.fromJson(json.decode(e)))
        .toList();

    return filterAndSortByCurrentWeek(models);
  }

  static List<CalendarModel> filterAndSortByCurrentWeek(
      List<CalendarModel> models) {
    final now =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    final startOfWeek =
        now.subtract(Duration(days: now.weekday - 1)); // Понедельник
    final endOfWeek = startOfWeek.add(Duration(days: 6)); // Воскресенье

    // Фильтруем модели, оставляя только те, что принадлежат текущей неделе
    List<CalendarModel> filteredModels = models.where((model) {
      return model.date.add(Duration(milliseconds: 100)).isAfter(startOfWeek) &&
          model.date.isBefore(endOfWeek.add(Duration(days: 1)));
    }).toList();

    // Сортируем отфильтрованные модели по дате
    filteredModels.sort((a, b) => a.date.compareTo(b.date));

    return filteredModels;
  }

  static List<double> calculateDurationsForCurrentWeek() {
    final models = getCurWeek();
    final now = DateTime.now();
    final startOfWeek = now
        .subtract(Duration(days: now.weekday - 1))
        .copyWith(hour: 0, minute: 0, second: 0); // Понедельник
    final endOfWeek = startOfWeek.add(Duration(days: 6)); // Воскресенье

    // Инициализируем карту для хранения сумм по дням недели
    Map<String, Duration> weeklyDurations = {
      'Monday': Duration.zero,
      'Tuesday': Duration.zero,
      'Wednesday': Duration.zero,
      'Thursday': Duration.zero,
      'Friday': Duration.zero,
      'Saturday': Duration.zero,
      'Sunday': Duration.zero,
    };

    // Обрабатываем каждую модель
    for (var model in models) {
      final start = model.date.copyWith(
          hour: model.start.hour, minute: model.start.minute, second: 0);
      final end = model.date
          .copyWith(hour: model.end.hour, minute: model.end.minute, second: 0);
      // Проверяем, попадает ли модель в текущую неделю
      if (start.isAfter(startOfWeek) &&
          start.isBefore(endOfWeek.add(Duration(days: 1)))) {
        // Находим день недели для start
        String dayName = DateFormat('EEEE').format(start);

        // Считаем разницу между start и end
        Duration duration = end.difference(start);

        // Добавляем к соответствующему дню
        weeklyDurations[dayName] = weeklyDurations[dayName]! + duration;
      }
    }

    return [
      weeklyDurations['Monday']!.inMinutes / 60,
      weeklyDurations['Tuesday']!.inMinutes / 60,
      weeklyDurations['Wednesday']!.inMinutes / 60,
      weeklyDurations['Thursday']!.inMinutes / 60,
      weeklyDurations['Friday']!.inMinutes / 60,
      weeklyDurations['Saturday']!.inMinutes / 60,
      weeklyDurations['Sunday']!.inMinutes / 60,
    ];
  }

  static List<FlSpot> calculateAverageDurationsForCurrentMonth() {
    final models = getForMonth(DateTime.now());
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth =
        DateTime(now.year, now.month + 1, 0); // Последний день месяца

    // Инициализируем карту для хранения сумм и счетчиков
    Map<String, List<Duration>> dailyDurations = {
      'Monday': [],
      'Tuesday': [],
      'Wednesday': [],
      'Thursday': [],
      'Friday': [],
      'Saturday': [],
      'Sunday': [],
    };

    // Обрабатываем каждую модель
    for (var model in models) {
      final start = model.date
          .copyWith(hour: model.start.hour, minute: model.start.minute);
      final end =
          model.date.copyWith(hour: model.end.hour, minute: model.end.minute);
      // Проверяем, попадает ли модель в текущий месяц
      if (start.isAfter(firstDayOfMonth.subtract(Duration(days: 1))) &&
          start.isBefore(lastDayOfMonth.add(Duration(days: 1)))) {
        // Находим день недели для start
        String dayName = DateFormat('EEEE').format(start);

        // Считаем разницу между start и end
        Duration duration = end.difference(start);

        // Добавляем к соответствующему дню
        dailyDurations[dayName]?.add(duration);
      }
    }

    // Теперь вычисляем средние значения
    Map<String, double> averageDurations = {};

    dailyDurations.forEach((day, durations) {
      if (durations.isNotEmpty) {
        // Суммируем продолжительности и находим среднее
        Duration totalDuration = durations.reduce((a, b) => a + b);
        double average =
            totalDuration.inMinutes / 60 / 4.346; // Среднее в минутах
        averageDurations[day] = average;
      } else {
        averageDurations[day] = 0; // Если нет моделей, возвращаем 0
      }
    });

    return [
      FlSpot(
        0,
        averageDurations['Monday'] ?? 0,
      ),
      FlSpot(
        1,
        averageDurations['Tuesday'] ?? 0,
      ),
      FlSpot(
        2,
        averageDurations['Wednesday'] ?? 0,
      ),
      FlSpot(
        3,
        averageDurations['Thursday'] ?? 0,
      ),
      FlSpot(
        4,
        averageDurations['Friday'] ?? 0,
      ),
      FlSpot(
        5,
        averageDurations['Saturday'] ?? 0,
      ),
      FlSpot(
        6,
        averageDurations['Sunday'] ?? 0,
      ),
    ];
  }

  static bool doesOverlap(CalendarModel newModel) {
    final existingModels = getAll();
    for (var model in existingModels) {
      // Проверяем, пересекается ли новый интервал с существующим
      if (newModel.date
              .copyWith(
                  hour: newModel.start.hour, minute: newModel.start.minute)
              .isBefore(model.date
                  .copyWith(hour: model.end.hour, minute: model.end.minute)) &&
          newModel.date
              .copyWith(hour: newModel.end.hour, minute: newModel.end.minute)
              .isAfter(model.date.copyWith(
                  hour: model.start.hour, minute: model.start.minute))) {
        return true; // Пересекается
      }
    }
    return false; // Не пересекается
  }
}
