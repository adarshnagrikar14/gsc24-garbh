import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:garbh/data/vaccine_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VaccineReminder extends StatefulWidget {
  const VaccineReminder({super.key});

  @override
  State<VaccineReminder> createState() => _VaccineReminderState();
}

class _VaccineReminderState extends State<VaccineReminder> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);
  String selectedDuration = '1 Week';

  @override
  Widget build(BuildContext context) {
    List<Map<String, List<String>>> filteredVaccines = vaccineDatas
        .where((vaccine) => vaccine.values.first.last == selectedDuration)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Vaccine Reminder",
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
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    buildFilterChip('1 Week'),
                    buildFilterChip('2 Weeks'),
                    buildFilterChip('3 Weeks'),
                    buildFilterChip('1 Month'),
                    buildFilterChip('2 Month'),
                    buildFilterChip('3 Month'),
                    buildFilterChip('4 Month'),
                    buildFilterChip('5 Month'),
                    buildFilterChip('1 Year'),
                  ],
                ),
              ),

              //
              Text(
                "Showing Vaccinations for $selectedDuration",
                style: const TextStyle(
                  fontSize: 16.0,
                ),
              ),

              //
              const Gap(20.0),
              Column(
                children: filteredVaccines
                    .map(
                      (vaccine) => VaccineCard(
                        name: vaccine.keys.first,
                        dosage: vaccine.values.first[1],
                        maxDate: vaccine.values.first[2],
                        pricing: vaccine.values.first[3],
                        tag: vaccine.values.first[4],
                        duration: vaccine.values.first[5],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFilterChip(String duration) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8.0,
        top: 8.0,
        bottom: 18.0,
      ),
      child: ChoiceChip(
        label: Text(
          duration,
          style: TextStyle(
            fontSize: 16,
            color: selectedDuration == duration ? Colors.white : Colors.black,
            fontWeight: selectedDuration == duration ? FontWeight.bold : null,
          ),
        ),
        showCheckmark: false,
        selectedColor: Colors.red.shade200,
        selected: selectedDuration == duration,
        onSelected: (selected) {
          setState(() {
            if (selected) {
              selectedDuration = duration;
            } else {
              selectedDuration = '';
            }
          });
        },
      ),
    );
  }
}

class VaccineCard extends StatefulWidget {
  final String name;
  final String dosage;
  final String maxDate;
  final String pricing;
  final String tag;
  final String duration;

  const VaccineCard({
    super.key,
    required this.name,
    required this.dosage,
    required this.maxDate,
    required this.pricing,
    required this.tag,
    required this.duration,
  });

  @override
  State<VaccineCard> createState() => _VaccineCardState();
}

class _VaccineCardState extends State<VaccineCard> {
  bool _isTaken = false;

  @override
  void initState() {
    super.initState();
    _loadIsTaken();
  }

  Future<void> _loadIsTaken() async {
    bool isTaken = await checkVaccineExists(widget.name);
    setState(() {
      _isTaken = isTaken;
    });
  }

  Future<bool> checkVaccineExists(String vaccineName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? markedVaccines = prefs.getStringList('marked_vaccines') ?? [];
    return markedVaccines.contains(vaccineName);
  }

  @override
  Widget build(BuildContext context) {
    //
    void markVaccineAsTaken(BuildContext context) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? markedVaccines =
          prefs.getStringList('marked_vaccines') ?? [];
      markedVaccines.add(widget.name);
      prefs.setStringList('marked_vaccines', markedVaccines);
      Fluttertoast.showToast(msg: "Marked as taken");
    }

    void showOptionsDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Vaccine: ${widget.name}"),
            actions: [
              TextButton(
                onPressed: () {
                  markVaccineAsTaken(context);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Mark as taken",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: 'Set custom reminder');
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Set custom reminder",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        if (!_isTaken) {
          showOptionsDialog(context);
        }
      },
      child: Card(
        elevation: 2.0,
        margin: const EdgeInsets.only(
          left: 3.0,
          right: 3.0,
          bottom: 25.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(
            12.0,
          ),
          // height: 120.0,
          child: Row(
            children: [
              Image.asset(
                "assets/images/injection.png",
                width: 60.0,
                fit: BoxFit.fitHeight,
              ),
              const Gap(5.00),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Vaccine: ${widget.name}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(5.0),
                    Text(
                      "Max Duration: ${widget.maxDate}",
                      style: const TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const Gap(5.0),
                    Text(
                      "Avg. Price: ${widget.pricing} Rs.",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    const Gap(8.0),
                    Text(
                      widget.tag,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8.0),
                    _isTaken
                        ? const Text(
                            "Vaccine Taken",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          )
                        : const Text(
                            "Click to set Reminder >",
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
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
