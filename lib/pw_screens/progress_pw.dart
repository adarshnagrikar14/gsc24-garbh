// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/reusables/piechart3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProgressPWScreen extends StatefulWidget {
  const ProgressPWScreen({super.key});

  @override
  State<ProgressPWScreen> createState() => _ProgressPWScreenState();
}

class _ProgressPWScreenState extends State<ProgressPWScreen> {
  List<int> currentCalories = [0, 0, 0, 0];
  List<List<String>> selectedChips = [
    [], //breakfast
    [], //lunch
    [], //snacks
    [], //dinner
  ];

  @override
  void initState() {
    super.initState();
    loadSavedValues();
  }

  void loadSavedValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? caloriesString = prefs.getString("currentCalories");
    if (caloriesString != null) {
      List<String> caloriesList = caloriesString.split(',');
      setState(() {
        currentCalories = caloriesList.map(int.parse).toList();
      });
    }

    String? selectedChipsString = prefs.getString("selectedChips");
    if (selectedChipsString != null) {
      List<List<String>> loadedChips =
          (json.decode(selectedChipsString) as List)
              .map((item) => List<String>.from(item))
              .toList();

      if (loadedChips.length == 4) {
        setState(() {
          selectedChips = loadedChips;
        });
      }
    }

    print("$currentCalories  $selectedChipsString");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Card(
                elevation: 2.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/images/progress_track.png",
                        width: 90.0,
                      ),
                      const Gap(12.0),
                      Expanded(
                        child: Text(
                          "You can check the progress of your diet, exercise, listening sessions, and more...",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ),
                      const Gap(5.0),
                    ],
                  ),
                ),
              ),

              //
              const Gap(18.0),
              const Text(
                "\tDiet Track",
                style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const PieChartSample3(),
            ],
          ),
        ),
      ),
    );
  }
}
