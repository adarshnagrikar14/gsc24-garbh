import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:garbh/dashboards/parent_dashboard.dart';
import 'package:garbh/dateselect.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dashboards/preg_women_dashboard.dart';

class UserTypePage extends StatefulWidget {
  const UserTypePage({super.key});

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  late String concDate;

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
    );

    concDate = "";

    getDateOfConception();
  }

  Future<void> getDateOfConception() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDate = prefs.getString("selectedDate");

    if (selectedDate != null) {
      setState(() {
        concDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select one"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              bottom: 25.0,
            ),
            child: Text(
              "I am a ",
              style: TextStyle(
                fontSize: 25.0,
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                if (concDate.isEmpty) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SelecDatePage(),
                    ),
                  );
                } else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PregnantWDashboard(),
                    ),
                  );
                }
              },
              child: ClipOval(
                child: Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(1.0),
                  child: Hero(
                    tag: "pregnantimage",
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/preg_women.jpg",
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 8.0,
              bottom: 25.0,
            ),
            child: Text(
              "Pregnant Women",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ParentDashboard(),
                  ),
                );
              },
              child: ClipOval(
                child: Container(
                  padding: const EdgeInsets.all(1.0),
                  color: Colors.black,
                  child: Hero(
                    tag: "parentimage",
                    child: ClipOval(
                      child: Image.asset(
                        "assets/images/parent.jpg",
                        width: 150.0,
                        height: 150.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 8.0,
            ),
            child: Text(
              "Parent",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // RoundedButton(
          //   text: 'Click',
          //   onTap: () {},
          // )
        ],
      ),
    );
  }
}
