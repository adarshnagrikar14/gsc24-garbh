import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenPW extends StatefulWidget {
  const HomeScreenPW({super.key});

  @override
  State<HomeScreenPW> createState() => _HomeScreenPWState();
}

class _HomeScreenPWState extends State<HomeScreenPW> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  late String userName;
  late String concDate;

  @override
  void initState() {
    super.initState();
    getUserDisplayName();

    getDateOfConception();
  }

  Future<void> getUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userName = user.displayName ?? "Dear User";
      });
    }
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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 12.0,
            right: 12.0,
            top: 15.0,
            bottom: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                " Hello, $userName",
                style: TextStyle(
                  color: Colors.grey.shade800,
                ),
              ),
              Card(
                elevation: 4.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.only(
                  top: 15.0,
                ),
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        // Colors.red.shade100,
                        Colors.white,
                        // Colors.white,
                        // Colors.white,
                        Colors.red.shade100,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomRight,
                      tileMode: TileMode.clamp,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Date: $concDate',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Description goes here.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'More details...',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
