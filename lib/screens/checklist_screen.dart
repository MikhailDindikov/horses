import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:horses/controllers/checklist_controller.dart';
import 'package:horses/models/checklist_model.dart';
import 'package:horses/screens/analytics_screen.dart';
import 'package:horses/screens/calendar_screen.dart';
import 'package:horses/utils/app_colors.dart';
import 'package:horses/utils/app_icons.dart';
import 'package:horses/utils/app_text.dart';
import 'package:horses/utils/app_utils.dart';

class ChecklistScreen extends StatefulWidget {
  const ChecklistScreen({super.key});

  @override
  State<ChecklistScreen> createState() => _ChecklistScreenState();
}

class _ChecklistScreenState extends State<ChecklistScreen> {
  final _controller = Get.find<ChecklistController>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.init();
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
          'Checklist',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
        leading: GestureDetector(
          onTap: () {
            Get.to(() => const CalendarScreen());
          },
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(AppIcons.calendar),
          ),
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
        child: GetBuilder(
            init: _controller,
            builder: (context) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 24, horizontal: 16),
                      itemBuilder: (context, index) => ChecklistCard(
                        model: _controller.models[index],
                      ),
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemCount: _controller.models.length,
                    ),
                    Obx(
                      () => AppUtils.prem.value
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: GestureDetector(
                                  onTap: () {
                                    Get.to(() => AddCheckList(model: null));
                                  },
                                  child: AddCard()),
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class ChecklistCard extends StatefulWidget {
  final ChecklistModel model;
  const ChecklistCard({super.key, required this.model});

  @override
  State<ChecklistCard> createState() => _ChecklistCardState();
}

class _ChecklistCardState extends State<ChecklistCard> {
  final _controller = ExpandableController();

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      controller: _controller,
      child: Expandable(
        collapsed: mainCard(false),
        expanded: Column(
          children: [
            mainCard(true),
            if (widget.model.sections.isNotEmpty)
              const SizedBox(
                height: 16,
              ),
            if (widget.model.sections.isNotEmpty)
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) =>
                    sectionCard(widget.model.sections[index]),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 12,
                ),
                itemCount: widget.model.sections.length,
              ),
            Obx(
              () => AppUtils.prem.value
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => AddCheckList(
                                model: widget.model,
                              ));
                        },
                        child: AddCard(),
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainCard(bool isExpanded) {
    return GestureDetector(
      onTap: () {
        _controller.toggle();
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isExpanded ? AppColors.passive : AppColors.stroke,
          ),
          color: isExpanded ? AppColors.stroke : AppColors.white,
        ),
        child: Row(
          children: [
            if (widget.model.iconPath != null)
              SvgPicture.asset(widget.model.iconPath!),
            if (widget.model.iconPath != null) const SizedBox(width: 6),
            Expanded(
              child: Text(
                widget.model.title,
                style: AppText.h4.copyWith(color: AppColors.black),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 12.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.stroke),
                color: AppColors.white,
              ),
              child: Text(
                '${widget.model.checkedCount}/${widget.model.sections.length}',
                style: AppText.h6.copyWith(color: AppColors.mainYellow),
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            RotatedBox(
              quarterTurns: isExpanded ? 3 : 1,
              child: SvgPicture.asset(AppIcons.next),
            ),
          ],
        ),
      ),
    );
  }

  Widget sectionCard(ChecklistSection model) {
    return GestureDetector(
      onTap: () {
        setState(() {
          model.isActive = !model.isActive;
        });
        Get.find<ChecklistController>().setChecklists();
      },
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.mainYellow,
          ),
          color: model.isActive ? AppColors.mainYellow : AppColors.white,
        ),
        child: Row(
          children: [
            Checkbox(
              checkColor: AppColors.mainYellow,
              activeColor: AppColors.white,
              value: model.isActive,
              onChanged: (val) {},
            ),
            Text(
              model.title,
              style: AppText.h4.copyWith(
                  color: model.isActive ? AppColors.white : AppColors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.stroke,
        ),
        color: AppColors.white,
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            AppIcons.add,
            color: AppColors.passive,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            'Add',
            style: AppText.h4.copyWith(color: AppColors.passive),
          ),
        ],
      ),
    );
  }
}

class AddCheckList extends StatefulWidget {
  final ChecklistModel? model;
  const AddCheckList({super.key, required this.model});

  @override
  State<AddCheckList> createState() => _AddCheckListState();
}

class _AddCheckListState extends State<AddCheckList> {
  late final TextEditingController _modelNameController =
      TextEditingController(text: widget.model?.title);
  late final List<String> _subnames =
      (widget.model?.sections ?? <ChecklistSection>[])
          .map((e) => e.title)
          .toList();

  void _addSubname() {
    setState(() {
      _subnames.add('');
    });
  }

  void _removeSubname(int index) {
    setState(() {
      _subnames.removeAt(index);
    });
  }

  void _updateSubname(int index, String value) {
    _subnames[index] = value;
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
          'Add checklist',
          style: AppText.h2.copyWith(color: AppColors.black),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'Name',
                    style: AppText.h5.copyWith(color: AppColors.black),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: _modelNameController,
                  decoration: InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Text(
                    'List',
                    style: AppText.h5.copyWith(color: AppColors.black),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _subnames.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Add check',
                              hintStyle:
                                  AppText.h5.copyWith(color: AppColors.passive),
                            ),
                            onChanged: (value) => _updateSubname(index, value),
                            controller:
                                TextEditingController(text: _subnames[index]),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: AppColors.passive,
                          ),
                          onPressed: () => _removeSubname(index),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: _addSubname,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.mainYellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Add list item',
                      style: AppText.h5.copyWith(color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                GestureDetector(
                  onTap: () {
                    if (widget.model == null) {
                      final controller = Get.find<ChecklistController>();
                      controller.models.add(
                        ChecklistModel(
                          id: UniqueKey().toString(),
                          title: _modelNameController.text,
                          iconPath: null,
                          sections: _subnames
                              .map((e) => ChecklistSection(title: e))
                              .toList(),
                        ),
                      );
                      controller.update();
                    } else {
                      Get.find<ChecklistController>().changeModel(
                        ChecklistModel(
                          id: widget.model!.id,
                          title: _modelNameController.text,
                          iconPath: widget.model!.iconPath,
                          sections: _subnames
                              .map((e) => ChecklistSection(title: e))
                              .toList(),
                        ),
                      );
                    }
                    Get.back();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.mainYellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Save',
                      style: AppText.h5.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
