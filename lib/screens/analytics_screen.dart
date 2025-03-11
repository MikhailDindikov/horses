import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/controllers/analytics_controller.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_text.dart';
import 'package:horses/utils/app_utils.dart';
import 'package:pie_chart/pie_chart.dart' as pch;

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final _gradients = [
    AppColors.mainYellow.withOpacity(0.2),
    AppColors.mainYellow.withOpacity(0),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = AppText.h6.copyWith(color: AppColors.mainDark);
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text('Mon', style: style);
        break;
      case 1:
        text = Text('Tue', style: style);
        break;
      case 2:
        text = Text('Wed', style: style);
        break;
      case 3:
        text = Text('Thu', style: style);
        break;
      case 4:
        text = Text('Fri', style: style);
        break;
      case 5:
        text = Text('Sat', style: style);
        break;
      case 6:
        text = Text('Sun', style: style);
        break;
      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: AxisSide.left,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = AppText.h6.copyWith(color: AppColors.mainDark);
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 3:
        text = '4h';
        break;
      case 7:
        text = '8h';
        break;
      case 11:
        text = '12h';
        break;
      case 15:
        text = '16h';
        break;
      case 19:
        text = '20h';
        break;
      case 23:
        text = '24h';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  final _controller = Get.find<AnalyticsController>();

  final waters = [
    'Stay hydrated—drink water before, during, and after riding.',
    'Avoid dehydration by sipping small amounts consistently.',
    'Electrolytes help replenish lost minerals after intense training.',
    'Cold weather? Don’t forget to drink—hydration is still key!',
    "Check urine color—light yellow means you're well-hydrated."
  ];

  final trains = [
    'Warm up properly to prevent injuries and improve performance.',
    'Focus on balance and core strength—it enhances riding stability.',
    'Quality over quantity—short, focused sessions are more effective.',
    'Cross-train with yoga or pilates for better flexibility.',
    'Listen to your horse—adjust training based on their response.',
  ];

  final sleeps = [
    'Aim for 7–9 hours of sleep to aid muscle recovery.',
    'Create a bedtime routine to improve sleep quality.',
    'Avoid screens before bed—blue light disrupts melatonin.',
    'Power naps (20–30 min) can boost energy before training.',
    'Sleep tracking can help optimize rest and performance.',
  ];

  final rand = Random();

  late final randWater = rand.nextInt(5);
  late final randTrain = rand.nextInt(5);
  late final randSleep = rand.nextInt(5);

  final slots = AppUtils.calculateAverageDurationsForCurrentMonth();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      _controller.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Analytics',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: GetBuilder(
            init: _controller,
            builder: (context) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16).copyWith(bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Wasted time',
                                  style: AppText.h3
                                      .copyWith(color: AppColors.black),
                                ),
                                SvgPicture.asset(AppIcons.timeR),
                              ],
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Text(
                              '${_controller.hoursSum} hours',
                              style:
                                  AppText.h2.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              'This week',
                              style:
                                  AppText.h6.copyWith(color: AppColors.black),
                            ),
                            const SizedBox(
                              height: 36,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _TimeColumn(
                                  day: 'Mon',
                                  hours: _controller.times[0],
                                ),
                                _TimeColumn(
                                  day: 'Tue',
                                  hours: _controller.times[1],
                                ),
                                _TimeColumn(
                                  day: 'Wed',
                                  hours: _controller.times[2],
                                ),
                                _TimeColumn(
                                  day: 'Thu',
                                  hours: _controller.times[3],
                                ),
                                _TimeColumn(
                                  day: 'Fri',
                                  hours: _controller.times[4],
                                ),
                                _TimeColumn(
                                  day: 'Sat',
                                  hours: _controller.times[5],
                                ),
                                _TimeColumn(
                                  day: 'Sun',
                                  hours: _controller.times[6],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: _DiagrammCard(
                              label: 'Wasted time',
                              cur: _controller.avgTime,
                              max: 24,
                              iconPath: AppIcons.horseB,
                              isHours: true,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: _DiagrammCard(
                              label: 'Weekdays',
                              cur: _controller.days.toDouble(),
                              max: 7,
                              iconPath: AppIcons.classesG,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16).copyWith(bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'This month',
                                    style: AppText.h4
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                                SvgPicture.asset(AppIcons.calendarB),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 280,
                              child: LineChart(
                                LineChartData(
                                  lineTouchData: LineTouchData(
                                    touchTooltipData: LineTouchTooltipData(
                                      getTooltipColor: (touchedSpot) =>
                                          AppColors.mainYellow,
                                      getTooltipItems: (touchedSpots) =>
                                          List.generate(
                                        touchedSpots.length,
                                        (index) => LineTooltipItem(
                                          '${touchedSpots.first.y.toStringAsFixed(1)}h',
                                          AppText.h4
                                              .copyWith(color: AppColors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: true,
                                    horizontalInterval: 1,
                                    verticalInterval: 1,
                                    getDrawingHorizontalLine: (value) {
                                      return const FlLine(
                                        color: Colors.transparent,
                                        strokeWidth: 1,
                                      );
                                    },
                                    getDrawingVerticalLine: (value) {
                                      return const FlLine(
                                        color: Colors.transparent,
                                        strokeWidth: 1,
                                      );
                                    },
                                  ),
                                  titlesData: FlTitlesData(
                                    show: true,
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 30,
                                        interval: 1,
                                        getTitlesWidget: bottomTitleWidgets,
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        interval: 1,
                                        getTitlesWidget: leftTitleWidgets,
                                        reservedSize: 42,
                                      ),
                                    ),
                                  ),
                                  borderData: FlBorderData(
                                    show: true,
                                    border:
                                        Border.all(color: Colors.transparent),
                                  ),
                                  minX: 0,
                                  maxX: 6,
                                  minY: 0,
                                  maxY: 25,
                                  lineBarsData: [
                                    LineChartBarData(
                                      spots:  slots,
                                      isCurved: true,
                                      color: AppColors.mainYellow,
                                      barWidth: 1,
                                      isStrokeCapRound: true,
                                      dotData: const FlDotData(
                                        show: false,
                                      ),
                                      belowBarData: BarAreaData(
                                        show: true,
                                        gradient: LinearGradient(
                                          colors: _gradients
                                              .map((color) =>
                                                  color.withOpacity(0.3))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16).copyWith(bottom: 24),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Advices',
                                    style: AppText.h4
                                        .copyWith(color: AppColors.black),
                                  ),
                                ),
                                SvgPicture.asset(AppIcons.advices),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                             IntrinsicHeight(
                               child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: _AdviceCard(
                                      title: 'Water',
                                      text: waters[randWater],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 21,
                                  ),
                                  Expanded(
                                    child: _AdviceCard(
                                      title: 'Train',
                                      text: trains[randTrain],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 21,
                                  ),
                                  Expanded(
                                    child: _AdviceCard(
                                      title: 'Sleep',
                                      text: sleeps[randSleep],
                                    ),
                                  ),
                                ],
                                                           ),
                             ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class _AdviceCard extends StatelessWidget {
  final String title;
  final String text;
  const _AdviceCard({required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Text(
            title,
            style: AppText.h6.copyWith(color: AppColors.mainYellow),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            text,
            style: AppText.h6.copyWith(color: AppColors.black),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _DiagrammCard extends StatelessWidget {
  final String label;
  final double cur;
  final double max;
  final String iconPath;
  final bool isHours;
  const _DiagrammCard({
    required this.label,
    required this.cur,
    required this.max,
    required this.iconPath,
    this.isHours = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16).copyWith(bottom: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: AppText.h5.copyWith(color: AppColors.black),
                ),
              ),
              SvgPicture.asset(iconPath),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          pch.PieChart(
            dataMap: {
              '1': cur,
              '2': max - cur,
            },
            colorList: const [AppColors.mainYellow, AppColors.stroke],
            initialAngleInDegree: 90,
            chartType: pch.ChartType.ring,
            ringStrokeWidth: 14,
            centerText:
                '${isHours ? cur.toStringAsFixed(1) : cur.round()}${isHours ? 'h' : ''}\n${isHours ? 'avg' : max.round()}',
            centerTextStyle: AppText.h4.copyWith(color: AppColors.black),
            chartValuesOptions: const pch.ChartValuesOptions(
              showChartValueBackground: false,
              showChartValues: false,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
            legendOptions: const pch.LegendOptions(
              showLegendsInRow: false,
              showLegends: false,
            ),
          ),
        ],
      ),
    );
  }
}

class _TimeColumn extends StatelessWidget {
  final String day;
  final double hours;
  const _TimeColumn({required this.day, required this.hours});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 104,
              width: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color.fromRGBO(245, 245, 245, 1),
                ),
              ),
            ),
            Container(
              height: 104 * hours / 24,
              width: 28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.mainYellow,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          day,
          style: AppText.h6.copyWith(color: AppColors.black),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          '${hours.toStringAsFixed(1)}h',
          style: AppText.footnote.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
