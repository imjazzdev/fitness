import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/tab_button.dart';
import 'package:fitness/view/home/home_view.dart';
import 'package:fitness/view/photo_progress/photo_progress_view.dart';
import 'package:fitness/view/profile/profile_view.dart';
import 'package:fitness/view/workout_tracker/workout_tracker_view.dart';
import 'package:flutter/material.dart';

class MainTabView extends StatefulWidget {
  final String username;
  final Map<String, dynamic>? newWorkout;

  const MainTabView({
    super.key,
    required this.username,
    this.newWorkout,
  });

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();
  late Widget currentTab;

  @override
  void initState() {
    super.initState();
    currentTab = HomeView(
      username: widget.username,
      newWorkout: widget.newWorkout,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: PageStorage(bucket: pageBucket, child: currentTab),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: 65,
            height: 65,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: TColor.white, boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 1, offset: Offset(0, -1))
          ]),
          height: kToolbarHeight + 10,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                child: TabButton(
                    icon: "assets/img/home_tab.png",
                    selectIcon: "assets/img/home_tab_select.png",
                    isActive: selectTab == 0,
                    onTap: () {
                      selectTab = 0;
                      currentTab = HomeView(
                        username: widget.username,
                        newWorkout: null,
                      );
                      if (mounted) {
                        setState(() {});
                      }
                    }),
              ),
              const Spacer(),
              Flexible(
                child: TabButton(
                    icon: "assets/img/activity_tab.png",
                    selectIcon: "assets/img/activity_tab_select.png",
                    isActive: selectTab == 1,
                    onTap: () {
                      selectTab = 1;
                      currentTab = const WorkoutTrackerView();
                      if (mounted) {
                        setState(() {});
                      }
                    }),
              ),
              const Spacer(),
              Flexible(
                child: TabButton(
                    icon: "assets/img/camera_tab.png",
                    selectIcon: "assets/img/camera_tab_select.png",
                    isActive: selectTab == 2,
                    onTap: () {
                      selectTab = 2;
                      currentTab = const PhotoProgressView();
                      if (mounted) {
                        setState(() {});
                      }
                    }),
              ),
              const Spacer(),
              Flexible(
                child: TabButton(
                  icon: "assets/img/profile_tab.png",
                  selectIcon: "assets/img/profile_tab_select.png",
                  isActive: selectTab == 3,
                  onTap: () {
                    selectTab = 3;
                    currentTab = ProfileView(
                        username:
                            widget.username); // Tambahkan username di sini
                    if (mounted) {
                      setState(() {});
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
