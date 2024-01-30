import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/parent_screens/alpha_music_child.dart';
import 'package:garbh/parent_screens/growth_child.dart';
import 'package:garbh/parent_screens/height_child.dart';
import 'package:garbh/parent_screens/lullaby_child.dart';
import 'package:garbh/parent_screens/weight_child.dart';
import 'package:garbh/reusables/custom_home_cards.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreenParent extends StatefulWidget {
  const HomeScreenParent({super.key});

  @override
  State<HomeScreenParent> createState() => _HomeScreenParentState();
}

class _HomeScreenParentState extends State<HomeScreenParent> {
  late String childmonth = "";
  late String userName = "";

  @override
  void initState() {
    super.initState();

    getUserDisplayName();
    getDateOfBirthOfChild();
  }

  Future<void> getUserDisplayName() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      setState(() {
        userName = user.displayName ?? "Dear User";
      });
    }
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
              Text(
                "Hey $userName,",
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const Gap(5.0),
              Text(
                "Find diet trackers, community tips, medicine reminders and more for your $childmonth month(s) old baby.",
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),

              //
              const Gap(22.0),
              const Text(
                "Track child's growth...",
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
                      imageName: "height_tr.png",
                      text: "Height",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HeightChart(),
                          ),
                        );
                      },
                    ),
                    const Gap(12.0),
                    CustomCard(
                      imageName: "weight_tr.png",
                      text: "Weight",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WeightChart(),
                          ),
                        );
                      },
                    ),
                    const Gap(12.0),
                    CustomCard(
                      imageName: "child_growth.png",
                      text: "Child Growth",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GrowthTrackerPage(),
                          ),
                        );
                      },
                    ),
                    const Gap(12.0),
                  ],
                ),
              ),

              //
              const Gap(22.0),
              const Text(
                "Refresh them with...",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Gap(15.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomCard(
                      imageName: "lullaby.png",
                      text: "Lullaby",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LullabyPage(),
                          ),
                        );
                      },
                    ),
                    const Gap(12.0),
                    CustomCard(
                      imageName: "alpha.png",
                      text: "\u03B1 Sound",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AlphaMusicPage(),
                          ),
                        );
                      },
                    ),
                    const Gap(12.0),
                  ],
                ),
              ),

              //
              const Gap(22.0),
              const Text(
                "Reminders",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20.0),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CustomCard(
                      imageName: "medicine.png",
                      text: "Medicines",
                    ),
                    Gap(12.0),
                    CustomCard(
                      imageName: "injection.png",
                      text: "Vaccination",
                    ),
                    Gap(12.0),
                  ],
                ),
              ),

              //
              Padding(
                padding: const EdgeInsets.only(
                  top: 60.0,
                  bottom: 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
