// ignore_for_file: avoid_print

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';

class DietPagePregnantWomen extends StatefulWidget {
  const DietPagePregnantWomen({super.key});

  @override
  State<DietPagePregnantWomen> createState() => _DietPagePregnantWomenState();
}

class _DietPagePregnantWomenState extends State<DietPagePregnantWomen> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  late String title = "Breakfast";
  late int cardPosition = 0;

  int currentCaloriesBreakfast = 0;
  int currentCaloriesLunch = 0;
  int currentCaloriesSnacks = 0;
  int currentCaloriesDinner = 0;

  List<String> selectedChipsBreakfast = [];
  List<String> selectedChipsLunch = [];
  List<String> selectedChipsDinner = [];
  List<String> selectedChipsSnacks = [];

  final List<String> carouselItems = [
    "Breakfast",
    "Lunch",
    "Snacks",
    "Dinner",
  ];

  final List<String> selectionOptionBreakfast = [
    "Poha",
    "Upma",
    "Dosa",
    "Paratha",
  ];

  final List<String> selectionOptionLunch = [
    "Dal",
    "Rice",
    "Curry",
    "Chapati",
  ];

  final List<String> selectionOptionSnacks = [
    "Pasta",
    "Samosa",
    "Bhel",
    "Laddoo",
  ];

  final List<String> selectionOptionDinner = [
    "Rice",
    "Vegetable Curry",
    "Dal",
    "Chapati",
  ];

  final List<int> calorieOption = [];

  @override
  void initState() {
    super.initState();

    calorieOption.add(currentCaloriesBreakfast);
    calorieOption.add(currentCaloriesLunch);
    calorieOption.add(currentCaloriesSnacks);
    calorieOption.add(currentCaloriesDinner);
  }

  Widget buildMealCard(
    String mealType,
    List<String> selectionOptions,
    List<String> selectedChips,
    int mealOption,
  ) {
    return Card(
      elevation: 2.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            const Gap(60.0),
            PieChartSample2(
              title: carouselItems[cardPosition],
              cardPosition: cardPosition,
            ),
            const Gap(30.0),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                elevation: 2.0,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "assets/images/select.png",
                          width: 50.0,
                          height: 50.0,
                        ),
                      ),
                      const Gap(12.0),
                      Expanded(
                        child: Text(
                          "Select all that you consumed...",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      const Gap(5.0),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(15.0),
            Text(
              "Current Calories: ${calorieOption[mealOption]} Cal.",
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: const EdgeInsets.only(
                top: 12.0,
                left: 18,
                right: 18.0,
                bottom: 20.0,
              ),
              child: LinearProgressIndicator(
                value: calorieOption[mealOption] / 400,
                minHeight: 12.0,
                backgroundColor: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.pink.shade300,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                selectionOptions.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    elevation: 1.5,
                    child: ChoiceChip(
                      label: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/apple.png",
                              height: 50.0,
                              width: 50.0,
                            ),
                            Text(selectionOptions[index]),
                          ],
                        ),
                      ),
                      selectedColor: Colors.red.shade100,
                      checkmarkColor: Colors.pink.shade300,
                      showCheckmark: false,
                      backgroundColor: const Color.fromARGB(185, 255, 235, 238),
                      selected: selectedChips.contains(selectionOptions[index]),
                      side: selectedChips.isEmpty
                          ? BorderSide(color: Colors.red.shade100)
                          : selectedChips.contains(selectionOptions[index])
                              ? BorderSide(color: Colors.red.shade600)
                              : BorderSide(color: Colors.red.shade100),
                      onSelected: (isSelected) {
                        setState(() {
                          isSelected
                              ? selectedChips.add(selectionOptions[index])
                              : selectedChips.remove(selectionOptions[index]);

                          if (isSelected) {
                            calorieOption[mealOption] =
                                calorieOption[mealOption] + 100;
                          }

                          print("$selectedChips");
                        });
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Diet Schedule",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: redColor,
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Card(
                elevation: 2.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/progress_track.png",
                        width: 90.0,
                      ),
                      const Gap(12.0),
                      Expanded(
                        child: Text(
                          "Keep track of your Diet here. Select the options you consumed under specific tabs.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      const Gap(5.0),
                    ],
                  ),
                ),
              ),

              const Gap(20.0),
              //
              Text(
                "\t$title",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20.0),

              //
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  aspectRatio: 0.4,
                  onPageChanged: (index, reason) {
                    setState(() {
                      title = carouselItems[index];
                      cardPosition = index;
                    });
                  },
                ),
                items: carouselItems.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return item == "Breakfast"
                          ? buildMealCard(
                              "Breakfast",
                              selectionOptionBreakfast,
                              selectedChipsBreakfast,
                              0,
                            )
                          : item == "Lunch"
                              ? buildMealCard(
                                  "Lunch",
                                  selectionOptionLunch,
                                  selectedChipsLunch,
                                  1,
                                )
                              : item == "Snacks"
                                  ? buildMealCard(
                                      "Snacks",
                                      selectionOptionSnacks,
                                      selectedChipsSnacks,
                                      2,
                                    )
                                  : buildMealCard(
                                      "Dinner",
                                      selectionOptionDinner,
                                      selectedChipsDinner,
                                      3,
                                    );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PieChartSample2 extends StatefulWidget {
  final String title;
  final int cardPosition;

  const PieChartSample2({
    super.key,
    required this.title,
    required this.cardPosition,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 5,
              centerSpaceRadius: 50,
              startDegreeOffset: widget.cardPosition == 0
                  ? 270
                  : widget.cardPosition == 1
                      ? 180
                      : 0,
              sections: showingSections(),
            ),
          ),
          Center(
            child: Text(
              widget.cardPosition == 0
                  ? "400 Cal."
                  : widget.cardPosition == 1
                      ? "600 Cal."
                      : widget.cardPosition == 2
                          ? "250 Cal."
                          : "600 Cal.",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    int cardPos = widget.cardPosition;

    return List.generate(4, (i) {
      const radius = 20.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red.shade400,
            title: "",
            radius: cardPos == 0 ? 28.0 : radius,
            badgePositionPercentageOffset: 2,
            badgeWidget: cardPos == 0
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 20%"),
                  )
                : const Center(),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red.shade200,
            value: 40,
            title: "",
            radius: cardPos == 1 ? 28.0 : radius,
            badgePositionPercentageOffset: 1.5,
            badgeWidget: cardPos == 1
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 40%"),
                  )
                : const Center(),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.pink.shade400,
            value: 10,
            title: "",
            radius: cardPos == 2 ? 28.0 : radius,
            badgePositionPercentageOffset: 1.5,
            badgeWidget: cardPos == 2
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 10%"),
                  )
                : const Center(),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.pink.shade200,
            value: 30,
            title: "",
            radius: cardPos == 3 ? 28.0 : radius,
            badgePositionPercentageOffset: 1.5,
            badgeWidget: cardPos == 3
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 30%"),
                  )
                : const Center(),
          );
        default:
          throw Error();
      }
    });
  }
}
