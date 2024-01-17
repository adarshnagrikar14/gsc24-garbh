import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:garbh/dashboards/preg_women_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelecDatePage extends StatefulWidget {
  const SelecDatePage({Key? key}) : super(key: key);

  @override
  State<SelecDatePage> createState() => _SelecDatePageState();
}

class _SelecDatePageState extends State<SelecDatePage> {
  late DateTime selectedDate;
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _updateDateText();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime oneYearAgo = currentDate.subtract(const Duration(days: 365));

    DateTime initialDate = selectedDate.isBefore(oneYearAgo)
        ? oneYearAgo
        : selectedDate.isAfter(currentDate)
            ? currentDate
            : selectedDate;

    final DateTime? picked = await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          margin: const EdgeInsets.all(
            13.0,
          ),
          height: 300.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0),
          ),
          // color: Colors.white,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: initialDate,
            minimumDate: oneYearAgo,
            maximumDate: currentDate,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                selectedDate = newDate;
              });
              _updateDateText();
            },
          ),
        );
      },
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _updateDateText();
      });
    }
  }

  void _updateDateText() {
    String formattedDate =
        '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}';
    _dateController.text = formattedDate;
  }

  Future<void> _saveDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDate', _dateController.text);

    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const PregnantWDashboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Select the date of conception",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 26.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _dateController,
                    readOnly: true,
                    scribbleEnabled: false,
                    decoration: const InputDecoration(
                      labelText: 'Date',
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                const Gap(20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: const Text("Select"),
                ),
              ],
            ),
            const Gap(35),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveDate,
              child: const Text(
                "Save and Proceed",
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
