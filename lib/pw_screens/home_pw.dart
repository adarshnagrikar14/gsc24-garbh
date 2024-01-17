import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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

  late String userName;
  late String concDate;
  late String concDays;

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
              Card(
                elevation: 2.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                color: Colors.transparent,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: 200.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red.shade100,
                      width: 1.0,
                    ),
                    gradient: LinearGradient(
                      colors: [
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/images/strawberry.png",
                        width: 120.0,
                        height: 100.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your fetus is the size of a strawberry at $concDays days.",
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            const Gap(20.0),
                            const Text(
                              "More Details",
                              style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w700,
                                color: Colors.redAccent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
                    Container(
                      width: 180.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/diet.png",
                              height: 140.0,
                              width: 130.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "Diet",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(12.0),
                    Container(
                      width: 180.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/exercise.png",
                              height: 140.0,
                              width: 120.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "Exercise",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(12.0),
                    Container(
                      width: 180.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/mentalhealth.png",
                              height: 140.0,
                              width: 130.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "Mental Health",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      width: 180.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                                "assets/images/music_l.png",
                                height: 130.0,
                                width: 130.0,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "Music",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(12.0),
                    Container(
                      width: 180.0,
                      height: 220.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                      ),
                      child: Card(
                        elevation: 4.0,
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/podcast.png",
                              height: 140.0,
                              fit: BoxFit.cover,
                              width: 120.0,
                            ),
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                                color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  "Podcast",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(12.0),
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
