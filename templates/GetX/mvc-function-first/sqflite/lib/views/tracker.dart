import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ftg_project_template/controllers/tracker_item.dart';
import 'package:ftg_project_template/views/dialog.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/controllers/tracker_list.dart';
import 'package:ftg_project_template/data/models/tracker.dart';


class TrackerListView extends GetView<TrackerListController> {
  @override
  Widget build(context) {
    return Scaffold(
      body: CustomScrollView(
        controller: Get.find<ScrollController>(),
        slivers: <Widget>[
          Obx(
            () => SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    for (Tracker tracker in controller.trackers)
                      TrackerItem(TrackerItemController(tracker)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return TrackerDialog(
                title: "Add new tracker",
                onSubmit: (item) => controller.addItem(item),
              );
            },
          )
        },
      ),
    );
  }
}

class TrackerItem extends StatelessWidget {
  final TrackerItemController controller;

  TrackerItem(this.controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Row(
            children: [
              Expanded(child: buildTextInfo(controller.tracker)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "1:37:08",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonBar(
                  buttonPadding: const EdgeInsets.all(8.0),
                  children: [
                    Icon(Icons.play_arrow),
                    GestureDetector(
                      onTap: () => Get.find<TrackerListController>().removeItem(controller.tracker),
                      child: Icon(Icons.delete),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ListTile buildTextInfo(Tracker object) {
    var title = Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Text(
        object.name,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
      ),
    );

    var subtitle = Text(
      object.description,
      style: TextStyle(fontSize: 13),
    );

    if (object.description.isBlank) {
      return ListTile(
        title: title,
      );
    } else {
      return ListTile(
        title: title,
        subtitle: subtitle,
      );
    }
  }
}
