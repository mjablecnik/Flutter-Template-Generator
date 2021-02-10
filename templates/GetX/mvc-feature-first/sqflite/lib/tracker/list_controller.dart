import 'package:get/get.dart';
import 'package:ftg_project_template/tracker/model.dart';
import 'package:ftg_project_template/tracker/repository.dart';

class TrackerListController extends GetxController {
  final TrackerRepository _trackerRepository = Get.find<TrackerRepository>();

  final List<Tracker> trackers = <Tracker>[].obs;

  onInit() {
    super.onInit();
    _load();
  }

  addItem(Tracker item) {
    trackers.add(item);
    _trackerRepository.insert(item);
    this.update();
  }

  removeItem(Tracker item) {
    trackers.remove(item);
    _trackerRepository.delete(item.id);
    this.update();
  }

  reorder(int oldIndex, int newIndex) {
    var row = trackers.removeAt(oldIndex);
    trackers.insert(newIndex, row);
  }

  _load() async {
    _trackerRepository.getAll().then((List<Tracker> trackerList) {
      if (trackerList.length == 0) {
        trackerList = <Tracker>[
          Tracker("Timetracker", description: "Programování ftg_project_templateu."),
          Tracker("Rss feed", description: "Programování Rss feedu."),
          Tracker("Jottings", description: "Programování Jottings aplikace."),
        ];
        trackerList.forEach(_trackerRepository.insert);
      }
      trackers.addAll(trackerList);
    });
  }
}
