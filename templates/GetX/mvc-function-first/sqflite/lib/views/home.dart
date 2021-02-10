import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ftg_project_template/controllers/home.dart';
import 'package:ftg_project_template/views/history.dart';
import 'package:ftg_project_template/views/review.dart';
import 'package:ftg_project_template/views/tracker.dart';


class TabNavigationItem {
  final Widget page;
  final String title;
  final Icon icon;

  TabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<TabNavigationItem> get items => [
    TabNavigationItem(
      page: TrackerListView(),
      icon: Icon(Icons.timelapse),
      title: "Time trackers",
    ),
    TabNavigationItem(
      page: ReviewView(),
      icon: Icon(Icons.list_alt),
      title: "Work review",
    ),
    TabNavigationItem(
      page: HistoryView(),
      icon: Icon(Icons.history),
      title: "History",
    ),
  ];
}

class HomeView extends StatelessWidget {
  @override
  Widget build(context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(title: Text("TimeTracker")),
        body: IndexedStack(
          index: controller.index.toInt(),
          children: [
            for (final tabItem in TabNavigationItem.items) tabItem.page,
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.index.toInt(),
          onTap: controller.changeIndex,
          items: [
            for (final tabItem in TabNavigationItem.items)
              BottomNavigationBarItem(
                icon: tabItem.icon,
                label: tabItem.title,
              )
          ],
        ),
      ),
    );
  }
}
