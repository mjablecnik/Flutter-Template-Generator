import 'package:ftg_project_template/tracker/model.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/tracker/repository.dart';

class TrackerItemController extends GetxController {
  final TrackerRepository _trackerRepository = Get.find<TrackerRepository>();

  Rx<Tracker> _tracker;

  get tracker => _tracker.value;

  TrackerItemController(Tracker tracker) {
    this._tracker = tracker.obs;
  }

  edit(Tracker item) {
    _trackerRepository.update(item);
    _tracker(item);
  }
}
