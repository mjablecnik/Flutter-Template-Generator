import 'package:get/get.dart';
import 'package:ftg_project_template/data/models/tracker.dart';
import 'package:ftg_project_template/data/repositories/tracker.dart';

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
