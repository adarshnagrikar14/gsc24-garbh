// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:garbh/pw_screens/community_pw.dart';
import 'package:garbh/pw_screens/home_pw.dart';
import 'package:garbh/pw_screens/progress_pw.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

class PregnantWDashboard extends StatefulWidget {
  const PregnantWDashboard({super.key});

  @override
  State<PregnantWDashboard> createState() => _PregnantWDashboardState();
}

class _PregnantWDashboardState extends State<PregnantWDashboard> {
  int _selectedIndex = 0;

  Future<bool> onBackPress() {
    if (_selectedIndex > 0) {
      setState(() {
        _selectedIndex = 0;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      const HomeScreenPW(),
      const ProgressPWScreen(),
      const CommunityPW(),
    ];

    Color redColor = const Color.fromARGB(255, 249, 76, 102);

    return WillPopScope(
      onWillPop: onBackPress,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 60.0,
          backgroundColor: redColor,
          elevation: 1.0,
          title: const Text(
            "Garbh",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8.0,
                right: 20.0,
                bottom: 8.0,
              ),
              child: ClipOval(
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(1.0),
                  child: Hero(
                    tag: "pregnantimage",
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/preg_women.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: SizedBox(
          height: 75.0,
          child: GNav(
            tabBorderRadius: 12,
            tabActiveBorder: Border.all(color: Colors.black, width: 1),
            gap: 8,
            color: Colors.grey[800],
            activeColor: Colors.red,
            iconSize: 28,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            tabs: const [
              GButton(
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                icon: LineIcons.helpingHands,
                text: 'Progress',
              ),
              GButton(
                icon: LineIcons.wiredNetwork,
                text: 'Community',
              ),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
