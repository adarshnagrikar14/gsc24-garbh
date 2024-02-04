import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({super.key});

  @override
  State<MedicineReminder> createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);
  List<Medicine> medicines = [];

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Medicine Reminder",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: redColor,
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddMedicineDialog();
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: medicines.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(6.0),
              child: ListView.builder(
                itemCount: medicines.length,
                itemBuilder: (context, index) {
                  final medicine = medicines[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          leading: Icon(
                            Icons.watch_later_outlined,
                            size: 40.0,
                            color: Colors.red.shade300,
                          ),
                          title: Text(
                            medicine.name,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Frequency: ${medicine.frequency}',
                                style: const TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              const Gap(5.0),
                              Text(
                                'Set on: ${medicine.dateString}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const Gap(5.0),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red.shade300,
                            ),
                            onPressed: () {
                              _deleteMedicine(index);
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : const Center(
              child: Text(
                "No Data Saved",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.black45,
                ),
              ),
            ),
    );
  }

  void _deleteMedicine(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? medicineList = prefs.getStringList('medicines_list');

    if (medicineList != null) {
      if (medicineList.isNotEmpty &&
          index >= 0 &&
          index < medicineList.length) {
        setState(() {
          medicineList.removeAt(index);
          prefs.setStringList('medicines_list', medicineList);
          _loadMedicines();
        });
      }
    }
  }

  void _loadMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? medicineJsonList = prefs.getStringList('medicines_list');
    if (medicineJsonList != null) {
      setState(() {
        medicines = medicineJsonList
            .map((json) => Medicine.fromJson(jsonDecode(json)))
            .toList();
      });
    }
  }

  void _saveMedicines(List<Medicine> medicines) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> jsonList =
        medicines.map((medicine) => jsonEncode(medicine.toJson())).toList();
    prefs.setStringList('medicines_list', jsonList);
  }

  Future<void> _showAddMedicineDialog() async {
    TextEditingController nameController = TextEditingController();
    String selectedFrequency = 'Once';
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Medicine'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Medicine Name',
                ),
              ),
              DropdownButtonFormField<String>(
                value: selectedFrequency,
                onChanged: (value) {
                  setState(() {
                    selectedFrequency = value!;
                  });
                },
                items: ['Once', 'Twice', 'Thrice'].map((frequency) {
                  return DropdownMenuItem<String>(
                    value: frequency,
                    child: Text(frequency),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  medicines.add(
                    Medicine(
                      name: nameController.text,
                      frequency: selectedFrequency,
                      dateString: "${DateTime.now()}",
                    ),
                  );
                });
                _saveMedicines(medicines);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class Medicine {
  final String name;
  final String frequency;
  final String dateString;

  Medicine({
    required this.name,
    required this.frequency,
    required this.dateString,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'frequency': frequency,
      'dateString': dateString,
    };
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      name: json['name'],
      frequency: json['frequency'],
      dateString: json['dateString'],
    );
  }
}
