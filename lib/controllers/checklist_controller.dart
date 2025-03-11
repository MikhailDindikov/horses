import 'package:get/get.dart';
import 'package:horses/models/checklist_model.dart';
import 'package:horses/utils/app_utils.dart';

class ChecklistController extends GetxController {
  List<ChecklistModel> models = [];

  void init() {
    models = AppUtils.getChecklists();
    update();
  }

  void setChecklists() {
    AppUtils.setChecklists(models);
  }

  void changeModel(ChecklistModel model) {
    final oldModel = models.where((e) => e.id == model.id).toList().first;
    for (final section in oldModel.sections) {
      if (model.sections.map((e) => e.title).contains(section.title)) {
        final repSection =
            model.sections.firstWhere((e) => e.title == section.title);
        repSection.isActive = section.isActive;
      }
    }

    final oldInd = models.indexOf(oldModel);
    models.remove(oldModel);
    models.insert(oldInd, model);
    update();

    setChecklists();
  }
}
