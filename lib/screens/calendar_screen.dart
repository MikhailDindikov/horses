import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/controllers/calendar_controller.dart';
import 'package:horses/models/calendar_model.dart';
import 'package:horses/models/training_model.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_text.dart';
import 'package:horses/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  final _weekdays = ['', 'M', 'T', 'W', 'T', 'F', 'S', 'S'];

  bool isEquals(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  final _controller = Get.find<CalendarController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Calendar',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
        actions: [
          GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.to(() => const AddScheduleScreen());
              },
              child: SvgPicture.asset(AppIcons.add)),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24).copyWith(top: 0),
          child: GetBuilder(
              init: _controller,
              builder: (context) {
                return Column(
                  children: [
                    Obx(
                      () => TableCalendar(
                        onDaySelected: (selectedDay, focusedDay) {
                          _controller.curDate.value = focusedDay;
                          _controller.getData();
                        },
                        onPageChanged: (focusedDay) {
                          _controller.curDate.value = focusedDay;
                          _controller.getData();
                        },
                        calendarFormat: CalendarFormat.week,
                        focusedDay: _controller.curDate.value,
                        firstDay: DateTime(DateTime.now().year - 1),
                        lastDay: DateTime(DateTime.now().year + 1),
                        calendarStyle: const CalendarStyle(),
                        rowHeight: 36,
                        daysOfWeekHeight: 36,
                        headerStyle: const HeaderStyle(
                          titleCentered: true,
                          formatButtonVisible: false,
                          leftChevronIcon: SizedBox(),
                          rightChevronIcon: SizedBox(),
                          leftChevronPadding: EdgeInsets.zero,
                          rightChevronPadding: EdgeInsets.zero,
                        ),
                        daysOfWeekStyle: DaysOfWeekStyle(
                          dowTextFormatter: (date, locale) =>
                              _weekdays[date.weekday],
                          weekdayStyle: AppText.c1.copyWith(
                            color: const Color.fromRGBO(187, 188, 190, 1),
                          ),
                          weekendStyle: AppText.c1.copyWith(
                            color: const Color.fromRGBO(187, 188, 190, 1),
                          ),
                        ),
                        calendarBuilders: CalendarBuilders(
                          defaultBuilder: (context, day, focusedDay) {
                            return Container(
                              height: 36,
                              width: 36,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isEquals(day, _controller.curDate.value)
                                    ? AppColors.mainYellow
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                day.day.toString(),
                                style: AppText.t2.copyWith(
                                  color:
                                      isEquals(day, _controller.curDate.value)
                                          ? AppColors.white
                                          : const Color.fromRGBO(50, 54, 62, 1),
                                ),
                              ),
                            );
                          },
                          todayBuilder: (context, day, focusedDay) {
                            return Container(
                              height: 36,
                              width: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isEquals(day, _controller.curDate.value)
                                    ? AppColors.mainYellow
                                    : null,
                              ),
                              child: Text(
                                day.day.toString(),
                                style: AppText.t2.copyWith(
                                  color:
                                      isEquals(day, _controller.curDate.value)
                                          ? AppColors.white
                                          : const Color.fromRGBO(50, 54, 62, 1),
                                ),
                              ),
                            );
                          },
                          outsideBuilder: (context, day, focusedDay) {
                            return Container(
                              height: 36,
                              width: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isEquals(day, _controller.curDate.value)
                                    ? AppColors.mainYellow
                                    : null,
                              ),
                              child: Text(
                                day.day.toString(),
                                style: AppText.t2.copyWith(
                                  color:
                                      isEquals(day, _controller.curDate.value)
                                          ? AppColors.white
                                          : const Color.fromRGBO(50, 54, 62, 1),
                                ),
                              ),
                            );
                          },
                          selectedBuilder: (context, day, focusedDay) {
                            return Container(
                              height: 36,
                              width: 36,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: isEquals(day, _controller.curDate.value)
                                    ? AppColors.mainYellow
                                    : null,
                              ),
                              child: Text(
                                day.day.toString(),
                                style: AppText.t2.copyWith(
                                  color:
                                      isEquals(day, _controller.curDate.value)
                                          ? AppColors.white
                                          : const Color.fromRGBO(50, 54, 62, 1),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_controller.data.isEmpty)
                      Expanded(
                        child: Center(
                          child: Text(
                            'Empty day',
                            style: AppText.h2.copyWith(color: AppColors.black),
                          ),
                        ),
                      )
                    else
                      ...List.generate(
                        _controller.data.length,
                        (index) => CalendarCard(
                          model: _controller.data[index],
                        ),
                      ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class CalendarCard extends StatelessWidget {
  final CalendarModel model;
  const CalendarCard({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Text(
                DateFormat('hh:mm a').format(model.start),
                style: AppText.h6.copyWith(color: AppColors.black),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                DateFormat('hh:mm a').format(model.end),
                style: AppText.footnote.copyWith(color: AppColors.passive),
              ),
            ],
          ),
          const SizedBox(
            width: 6,
          ),
          Column(
            children: [
              Container(
                height: 26,
                width: 26,
                padding: const EdgeInsets.all(1),
                decoration: const BoxDecoration(
                  color: AppColors.mainYellow,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.white),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: 4,
                  color: AppColors.mainYellow,
                ),
              )
            ],
          ),
          const SizedBox(
            width: 5,
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 22),
              padding: const EdgeInsets.all(12),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: AppText.h4.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    model.note,
                    style: AppText.h6.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddScheduleScreen extends StatefulWidget {
  const AddScheduleScreen({super.key});

  @override
  State<AddScheduleScreen> createState() => _AddScheduleScreenState();
}

class _AddScheduleScreenState extends State<AddScheduleScreen> {
  final List<String> _days = <String>[
    '1 Day',
    '2 Days',
    '3 Days',
    '4 Days',
    '5 Days',
    '6 Days',
    '7 Days',
  ];

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The bottom margin is provided to align the popup above the system
        // navigation bar.
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(top: false, child: child),
      ),
    );
  }

  DateTime? date;
  DateTime? notificationDuration;
  DateTime? startTime;
  DateTime? endTime;
  int daysIndex = 0;
  final title = TextEditingController();
  final note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Add Schedule',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Event name',
                  style: AppText.h5.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: title,
                style: AppText.h5.copyWith(color: AppColors.black),
                decoration: InputDecoration(
                  prefixIcon: IntrinsicWidth(
                    child: Container(
                      padding: const EdgeInsets.only(left: 16),
                      alignment: Alignment.centerLeft,
                      child: SvgPicture.asset(AppIcons.horseBl),
                    ),
                  ),
                  hintText: 'Equestrian',
                  hintStyle: AppText.h5.copyWith(color: AppColors.passive),
                  fillColor: const Color.fromRGBO(248, 248, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Date & how long',
                  style: AppText.h5.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          useMagnifier: true,
                          itemExtent: 30,
                          // This sets the initial item.
                          scrollController: FixedExtentScrollController(
                              initialItem: daysIndex),
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            setState(() {
                              daysIndex = selectedItem;
                            });
                          },
                          children:
                              List<Widget>.generate(_days.length, (int index) {
                            return Center(child: Text(_days[index]));
                          }),
                        ),
                      ),
                      child: CalendarContainer(
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.days),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                _days[daysIndex],
                                style:
                                    AppText.h6.copyWith(color: AppColors.black),
                              ),
                            ),
                            SvgPicture.asset(
                              AppIcons.bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: date ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.date,
                          use24hFormat: false,
                          // This shows day of week alongside day of month
                          showDayOfWeek: true,
                          // This is called when the user changes the date.
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => date = newDate);
                          },
                        ),
                      ),
                      child: CalendarContainer(
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.dateTF),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                date == null
                                    ? 'Select'
                                    : DateFormat('d MMM').format(date!),
                                style:
                                    AppText.h6.copyWith(color: AppColors.black),
                              ),
                            ),
                            SvgPicture.asset(
                              AppIcons.bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Notification',
                  style: AppText.h5.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              GestureDetector(
                onTap: () => _showDialog(
                  CupertinoDatePicker(
                    initialDateTime: notificationDuration ?? DateTime.now(),
                    mode: CupertinoDatePickerMode.time,
                    use24hFormat: false,
                    // This is called when the user changes the time.
                    onDateTimeChanged: (DateTime newTime) {
                      setState(() => notificationDuration = newTime);
                    },
                  ),
                ),
                child: CalendarContainer(
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.notification),
                      SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          notificationDuration == null
                              ? 'None'
                              : DateFormat('hh:mm a')
                                  .format(notificationDuration!),
                          style: AppText.h4.copyWith(color: AppColors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Event time',
                  style: AppText.h5.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: startTime ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: false,
                          // This is called when the user changes the time.
                          onDateTimeChanged: (DateTime newTime) {
                            setState(() => startTime = newTime);
                          },
                        ),
                      ),
                      child: CalendarContainer(
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.time2),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                startTime == null
                                    ? 'Select'
                                    : DateFormat('hh:mm a').format(startTime!),
                                style:
                                    AppText.h6.copyWith(color: AppColors.black),
                              ),
                            ),
                            SvgPicture.asset(
                              AppIcons.bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showDialog(
                        CupertinoDatePicker(
                          initialDateTime: endTime ?? DateTime.now(),
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: false,
                          // This is called when the user changes the time.
                          onDateTimeChanged: (DateTime newTime) {
                            setState(() => endTime = newTime);
                          },
                        ),
                      ),
                      child: CalendarContainer(
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.time2),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              child: Text(
                                endTime == null
                                    ? 'Select'
                                    : DateFormat('hh:mm a').format(endTime!),
                                style:
                                    AppText.h6.copyWith(color: AppColors.black),
                              ),
                            ),
                            SvgPicture.asset(
                              AppIcons.bottom,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Description',
                  style: AppText.h5.copyWith(color: AppColors.black),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: note,
                style: AppText.h5.copyWith(color: AppColors.black),
                minLines: 3,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Note',
                  hintStyle: AppText.h5.copyWith(color: AppColors.passive),
                  fillColor: const Color.fromRGBO(248, 248, 246, 1),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  if (title.text.isNotEmpty &&
                      startTime != null &&
                      endTime != null &&
                      date != null) {
                    if (startTime!.hour == endTime!.hour
                        ? startTime!.minute < endTime!.minute
                        : startTime!.hour < endTime!.hour) {
                      final model = CalendarModel(
                          title: title.text,
                          date: date!,
                          start: startTime!,
                          end: endTime!,
                          note: note.text);
                      if (AppUtils.doesOverlap(model)) {
                        Get.showSnackbar(GetSnackBar(
                          duration: Duration(seconds: 2),
                          backgroundColor: AppColors.mainYellow,
                          messageText:
                              Text('Already have training at this time'),
                        ));
                      } else {
                        AppUtils.saveCalendars(
                          model,
                          notificationDuration,
                          daysIndex + 1,
                        );

                        Get.back();
                      }
                    } else {
                      Get.showSnackbar(GetSnackBar(
                        duration: Duration(seconds: 2),
                        backgroundColor: AppColors.mainYellow,
                        messageText: Text('"Event time" is incorrect'),
                      ));
                    }
                  } else {
                    Get.showSnackbar(GetSnackBar(
                      duration: Duration(seconds: 2),
                      backgroundColor: AppColors.mainYellow,
                      messageText: Text(
                          'Please, select "Event time" and Date. Also enter "Equestrian"'),
                    ));
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 22),
                  decoration: BoxDecoration(
                    color: AppColors.mainYellow,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Save',
                    style: AppText.buttons.copyWith(color: AppColors.black),
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

class CalendarContainer extends StatelessWidget {
  final Widget child;
  const CalendarContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: const Color.fromRGBO(248, 248, 246, 1)),
      child: child,
    );
  }
}
