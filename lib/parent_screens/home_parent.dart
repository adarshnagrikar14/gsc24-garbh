import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenParent extends StatefulWidget {
  const HomeScreenParent({
    super.key,
  });

  @override
  State<HomeScreenParent> createState() => _HomeScreenParentState();
}

class _HomeScreenParentState extends State<HomeScreenParent> {
  late String childmonth;

  @override
  void initState() {
    super.initState();

    childmonth = "";

    getDateOfBirthOfChild();
  }

  Future<void> getDateOfBirthOfChild() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDate = prefs.getString("selectedDateChild");

    if (selectedDate != null) {
      setState(() {
        childmonth = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            15.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 60.0,
                  bottom: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(childmonth),
                    Text(
                      "Live\nParenting",
                      style: TextStyle(
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                        height: 1.2,
                        letterSpacing: 1.5,
                        fontFamily: GoogleFonts.lilitaOne().fontFamily,
                      ),
                    ),
                    Text(
                      "\nWhich is a journey of love, patience, and growth. In guiding our children, we learn the true meaning of selflessness and discover the extraordinary in the ordinary moments",
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
