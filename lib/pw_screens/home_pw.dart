import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/pw_screens/diet_pw.dart';
import 'package:garbh/pw_screens/exercise_pw.dart';
import 'package:garbh/pw_screens/meditation_pw.dart';
import 'package:garbh/reusables/custom_home_cards.dart';
import 'package:garbh/reusables/custom_home_infocard.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenPW extends StatefulWidget {
  const HomeScreenPW({super.key});

  @override
  State<HomeScreenPW> createState() => _HomeScreenPWState();
}

class _HomeScreenPWState extends State<HomeScreenPW> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  late String userName = "";
  late String concDate;
  late String concDays;

  late int concDaysInt = 0;

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

      calculateDaysDifference(concDate);
    }
  }

  String calculateDaysDifference(String selectedDateString) {
    DateTime selectedDate = DateFormat('dd-MM-yyyy').parse(selectedDateString);
    DateTime currentDate = DateTime.now();
    int differenceInDays = currentDate.difference(selectedDate).inDays;
    String daysDifferenceString = differenceInDays.toString();

    setState(() {
      concDays = daysDifferenceString;
      concDaysInt = int.parse(concDays);
    });

    return daysDifferenceString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 13.0,
            right: 15.0,
            top: 15.0,
            bottom: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Text(
                " Hello, $userName",
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16.0,
                  fontFamily: GoogleFonts.rubik().fontFamily,
                ),
              ),
              const Gap(6),

              //
              CustomInfoCard(
                imageAsset: "assets/images",
                concDays: concDaysInt,
              ),

              //
              const Gap(22.0),
              const Text(
                "My Health streak...",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //
              const Gap(15.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomCard(
                      imageName: "diet.png",
                      text: "Diet",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DietPagePregnantWomen(),
                          ),
                        );
                      },
                    ),
                    const Gap(12.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ExerciseScreen(),
                          ),
                        );
                      },
                      child: const CustomCard(
                        imageName: "exercise.png",
                        text: "Exercise",
                      ),
                    ),
                    const Gap(12.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MeditationScreen(),
                          ),
                        );
                      },
                      child: const CustomCard(
                        imageName: "mentalhealth.png",
                        text: "Meditation",
                      ),
                    ),
                  ],
                ),
              ),

              //
              const Gap(22.0),
              const Text(
                "Take a break 😌",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Gap(15.0),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomCard(
                      imageName: "music_l.png",
                      text: "Music",
                    ),
                    Gap(12.0),
                    CustomCard(
                      imageName: "podcast.png",
                      text: "Podcast",
                    ),
                    Gap(12.0),
                  ],
                ),
              ),

              // Bottom lines
              Padding(
                padding: const EdgeInsets.only(
                  top: 60.0,
                  bottom: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Stay\nPositive",
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
                      "\nYour journey is as unique as you are. Embrace the moments, and let the excitement of new beginnings fill each day with joy and anticipation.",
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
