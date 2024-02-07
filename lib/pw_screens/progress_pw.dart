// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/actual_data/meal_data.dart';
// import 'package:garbh/data/meal_data.dart';
import 'package:garbh/pw_screens/diet_pw.dart';
import 'package:garbh/reusables/piechart3.dart';
import 'package:garbh/reusables/piechart4.dart';
import 'package:line_icons/line_icon.dart';
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

  late int totalExerciseCalBurn = 1;

  @override
  void initState() {
    super.initState();
    loadSavedValues();
    loadExerciseHistory();
  }

  Future<List<List<String>>> loadExerciseHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? exerciseHistory = prefs.getStringList("exerciseHistory");

    if (exerciseHistory == null) {
      return [];
    }

    List<List<String>> formattedExerciseHistory = [];
    for (int i = 0; i < exerciseHistory.length; i += 2) {
      totalExerciseCalBurn += int.parse(exerciseHistory[i + 1]);
      formattedExerciseHistory.add([
        exerciseHistory[i],
        exerciseHistory[i + 1],
      ]);
    }
    print(formattedExerciseHistory);

    setState(() {
      totalExerciseCalBurn = totalExerciseCalBurn - 1;
    });

    return formattedExerciseHistory;
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
              const Gap(22.0),
              const Text(
                "\tExercise Track",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5.0),
              const Text(
                "\tCalorie burnt for the day after performing\n\texercises",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              //
              const Gap(15.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(
                    12.0,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: CustomExercisePieChart(
                          totalExerciseCalBurn: totalExerciseCalBurn / 1,
                        ),
                      ),
                      const Expanded(
                        flex: 4,
                        child: Text(
                          "The Exercises you perform will be shown and calorie burn will be calculated accordingly.",
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              //
              const Gap(18.0),
              const Text(
                "\tDiet Track",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5.0),
              const Text(
                "\tClick on individuals to see detailed report.",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),

              //
              const Gap(12.0),
              Card(
                child: Padding(
                  padding: const EdgeInsets.only(
                    bottom: 15.0,
                    top: 10.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InfoDialog(
                                      dietItemList: selectedChips,
                                      calorielist: currentCalories,
                                      title: "Fats",
                                      mealOption: 0,
                                    );
                                  },
                                );
                              },
                              child: const CustomizablePieChart(
                                title1: "Fats",
                                progress1: 20,
                              ),
                            ),
                          ),
                          const Gap(12.0),
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return InfoDialog(
                                      dietItemList: selectedChips,
                                      calorielist: currentCalories,
                                      title: "Protiens",
                                      mealOption: 1,
                                    );
                                  },
                                );
                              },
                              child: const CustomizablePieChart(
                                title1: "Protiens",
                                progress1: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(16.0),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return InfoDialog(
                                        dietItemList: selectedChips,
                                        calorielist: currentCalories,
                                        title: "Carbohydrates",
                                        mealOption: 2,
                                      );
                                    },
                                  );
                                },
                                child: const CustomizablePieChart(
                                  title1: "Carbohydrates",
                                  progress1: 25,
                                ),
                              ),
                            ),
                            const Gap(12.0),
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return InfoDialog(
                                        dietItemList: selectedChips,
                                        calorielist: currentCalories,
                                        title: "Calories",
                                        mealOption: 3,
                                      );
                                    },
                                  );
                                },
                                child: const CustomizablePieChart(
                                  title1: "Calories",
                                  progress1: 55,
                                ),
                              ),
                            ),
                          ],
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

class InfoDialog extends StatefulWidget {
  final List<List<String>> dietItemList;
  final List<int> calorielist;
  final String title;
  final int mealOption;
  const InfoDialog({
    super.key,
    required this.dietItemList,
    required this.calorielist,
    required this.title,
    required this.mealOption,
  });

  @override
  State<InfoDialog> createState() => InfoDialogState();
}

class InfoDialogState extends State<InfoDialog> {
  //Meal Data
  List<List<Map<String, List<String>>>> mealData = mealDatas;

  double calculateSum(List<int> values) {
    return values
        .map((value) => value.toDouble())
        .reduce((value, element) => value + element);
  }

  double calculateTotalFats(List<List<String>> dietItemList) {
    double totalFats = 0.0;

    for (int i = 0; i < dietItemList.length; i++) {
      for (int j = 0; j < dietItemList[i].length; j++) {
        String itemName = dietItemList[i][j];

        for (int k = 0; k < mealDatas[i].length; k++) {
          Map<String, List<String>> mealData = mealDatas[i][k];
          if (mealData.containsKey(itemName)) {
            String nutritionalInfo = mealData[itemName]![2];
            RegExp regex = RegExp(r'Fats: (\d+)gm');
            RegExpMatch? match = regex.firstMatch(nutritionalInfo);

            if (match != null) {
              String? fatsValue = match.group(1);
              totalFats += double.parse(fatsValue!);
            }
          }
        }
      }
    }

    return totalFats;
  }

  double calculateTotalProteins(List<List<String>> dietItemList) {
    double totalProteins = 0.0;

    for (int i = 0; i < dietItemList.length; i++) {
      for (int j = 0; j < dietItemList[i].length; j++) {
        String itemName = dietItemList[i][j];

        for (int k = 0; k < mealDatas[i].length; k++) {
          Map<String, List<String>> mealData = mealDatas[i][k];
          if (mealData.containsKey(itemName)) {
            String nutritionalInfo = mealData[itemName]![2];
            RegExp regex = RegExp('Protien: (\\d+)gm');
            RegExpMatch? match = regex.firstMatch(nutritionalInfo);

            if (match != null) {
              String? proteinValue = match.group(1);
              totalProteins += double.parse(proteinValue!);
            }
          }
        }
      }
    }

    return totalProteins;
  }

  double calculateTotalCarbs(List<List<String>> dietItemList) {
    double totalCarbs = 0.0;

    for (int i = 0; i < dietItemList.length; i++) {
      for (int j = 0; j < dietItemList[i].length; j++) {
        String itemName = dietItemList[i][j];

        for (int k = 0; k < mealDatas[i].length; k++) {
          Map<String, List<String>> mealData = mealDatas[i][k];
          if (mealData.containsKey(itemName)) {
            String nutritionalInfo = mealData[itemName]![2];
            RegExp regex = RegExp('Carbs: (\\d+)gm');
            RegExpMatch? match = regex.firstMatch(nutritionalInfo);

            if (match != null) {
              String? carbsValue = match.group(1);
              totalCarbs += double.parse(carbsValue!);
            }
          }
        }
      }
    }

    return totalCarbs;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(BuildContext context) {
    double totalWeightOfContent = widget.mealOption == 0
        ? calculateTotalFats(widget.dietItemList)
        : widget.mealOption == 1
            ? calculateTotalProteins(widget.dietItemList)
            : widget.mealOption == 2
                ? calculateTotalCarbs(widget.dietItemList)
                : calculateSum(widget.calorielist);

    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "${widget.title} Report",
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(10.0),
          Text(
            "1. Your total consumption of ${widget.title} is $totalWeightOfContent ${widget.mealOption == 3 ? "Cal" : "gm"}.",
            style: const TextStyle(
              fontSize: 17.0,
            ),
          ),
          const Gap(12.0),
          Text(
            "2. You need to consume ${1000 - totalWeightOfContent} ${widget.mealOption == 3 ? "Cal." : "gm"} ${widget.title} to complete your diet.",
            style: const TextStyle(
              fontSize: 17.0,
            ),
          ),
          const Gap(32.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12.0,
              ),
              border: Border.all(),
              color: const Color.fromARGB(115, 255, 235, 238),
            ),
            child: ListTile(
              title: const Text("Go to Diet"),
              selected: true,
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DietPagePregnantWomen(),
                  ),
                );
              },
              trailing: const LineIcon.forward(
                size: 22.0,
              ),
            ),
          ),
          const Gap(20.0),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ),
        ],
      ),
    );
  }
}
