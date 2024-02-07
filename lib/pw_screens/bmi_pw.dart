import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BMITracker extends StatefulWidget {
  const BMITracker({super.key});

  @override
  State<BMITracker> createState() => _BMITrackerState();
}

class _BMITrackerState extends State<BMITracker> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  late String weight = "0";
  late String height = "1";

  @override
  void initState() {
    super.initState();
    _loadUserDetails();
  }

  _loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? weight = prefs.getString('weight');
    String? height = prefs.getString('height');
    if (weight != null && height != null) {
      weightController.text = weight;
      heightController.text = height;

      setState(() {
        this.weight = weight;
        this.height = height;
      });
    } else {
      _showInputDialog();
    }
  }

  _showInputDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Pre-pregnancy Weight and Height'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: 'Weight (in K.Gs)'),
              ),
              TextField(
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (in CMs)'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                if (weightController.text.isEmpty ||
                    heightController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Enter Data");
                } else {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('weight', weightController.text);
                  prefs.setString('height', heightController.text);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Check",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 76, 102),
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pre-pregnancy weight',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const Gap(12.0),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5.0,
                  top: 8.0,
                ),
                child: DataTable(
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'BMI Category',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Recommended\nWeight Gain',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('Underweight (BMI under 18.5)')),
                      DataCell(Text('28 to 40 lbs. (about 13 to 18 kg)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Normal weight (BMI 18.5 to 24.9)')),
                      DataCell(Text('25 to 35 lbs. (about 11 to 16 kg)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Overweight (BMI 25 to 29.9)')),
                      DataCell(Text('15 to 25 lbs. (about 7 to 11 kg)')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('Obesity (BMI 30 or more)')),
                      DataCell(Text('11 to 20 lbs. (about 5 to 9 kg)')),
                    ]),
                  ],
                ),
              ),
              const Gap(20.0),
              const Text(
                'Below Data is for women pregnant with Twins*',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 5.0,
                  top: 8.0,
                ),
                child: DataTable(
                  columnSpacing: 16.0,
                  border: TableBorder.all(),
                  columns: const [
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'BMI Before pregnancy',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Recommended\nweight Gain',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text(
                        'Underweight: BMI less than 18.5',
                        textAlign: TextAlign.start,
                      )),
                      DataCell(Text(
                        '23-28 kg',
                        textAlign: TextAlign.start,
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Normal Weight: BMI 18.5-24.9',
                        textAlign: TextAlign.start,
                      )),
                      DataCell(Text(
                        '17-25 kg',
                        textAlign: TextAlign.start,
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Overweight: BMI 25.0-29.9',
                        textAlign: TextAlign.start,
                      )),
                      DataCell(Text(
                        '14-23 kg',
                        textAlign: TextAlign.start,
                      )),
                    ]),
                    DataRow(cells: [
                      DataCell(Text(
                        'Obese: BMI greater than or equal to 30.0',
                        textAlign: TextAlign.start,
                      )),
                      DataCell(Text(
                        '11-19 kg',
                        textAlign: TextAlign.start,
                      )),
                    ]),
                  ],
                ),
              ),
              const Gap(20.0),
              const Text(
                'Source: Institute of Medicine and National Research Council',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                ),
              ),

              //
              const Gap(20),
              const Text(
                'Your entered data',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const Gap(10),
              Text(
                "Weight: $weight KG, Height: $height Cms",
                style: const TextStyle(
                  fontSize: 18.0,
                ),
              ),
              const Gap(10),
              Text(
                "BMI: ${calculateBMI(
                  double.parse(weight),
                  double.parse(height),
                ).toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

              //
              const Gap(20.0),
              Card(
                elevation: 2.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.asset(
                        "assets/images/bmi.png",
                        width: 90.0,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                      const Gap(18.0),
                      Expanded(
                        child: Text(
                          "Your Pre-pregnency BMI is ${calculateBMI(
                            double.parse(weight),
                            double.parse(height),
                          ).toStringAsFixed(2)} which makes it ${interpretBMI(
                            calculateBMI(
                              double.parse(weight),
                              double.parse(height),
                            ),
                          )} interpretation.",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Gap(5.0),
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

  String interpretBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi >= 18.5 && bmi < 25) {
      return 'Normal weight';
    } else if (bmi >= 25 && bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  double calculateBMI(double weightKg, double heightCm) {
    double heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }
}
