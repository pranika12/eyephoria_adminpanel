import 'dart:async';

import 'package:admin_panel_pranika_fyp/controller/authentication_controller.dart';
import 'package:admin_panel_pranika_fyp/pages/loader.dart';
import 'package:admin_panel_pranika_fyp/tabs/tab_one.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tabnavigator/tabnavigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final _tabController = StreamController<AppTab>.broadcast();
  final _initTab = AppTab.home;

  Stream<AppTab> get tabStream => _tabController.stream;

  final _map = <AppTab, TabBuilder>{
    AppTab.home: () {
      return TabOne();
    },
    AppTab.colors: () {
      return Column(
        children: const [],
      );
    },
    AppTab.info: () {
      final authentication = Get.find<Authentication>();
      return Column(
        children: [
          Container(
              child: ElevatedButton(
                  onPressed: () async {
                    await authentication.logout();
                    Get.offAll(const Loader());
                  },
                  child: const Text("Logout"))),
        ],
      );
    }
  };

  logout() async {}

  Widget _buildBody() {
    return TabNavigator(
      initialTab: _initTab,
      selectedTabStream: tabStream,
      mappedTabs: _map,
    );
  }

  Widget _buildbottomNavigationBar() {
    return StreamBuilder<AppTab>(
      stream: tabStream,
      initialData: _initTab,
      builder: (context, snapshot) {
        return BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.color_lens),
              label: 'Colors',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.face),
              label: 'Profile',
            ),
          ],
          currentIndex: snapshot.hasData ? snapshot.data!.value : 0,
          onTap: (value) => _tabController.sink.add(AppTab.byValue(value)),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildbottomNavigationBar(),
    );
  }

  @override
  void dispose() {
    _tabController.close();
    super.dispose();
  }
}

class AppTab extends TabType {
  const AppTab._(int value) : super(value);

  static const home = AppTab._(0);
  static const colors = AppTab._(1);
  static const info = AppTab._(2);

  static AppTab byValue(int value) {
    switch (value) {
      case 0:
        return home;
      case 1:
        return colors;
      case 2:
        return info;
      default:
        throw Exception('no tab for such value');
    }
  }
}
