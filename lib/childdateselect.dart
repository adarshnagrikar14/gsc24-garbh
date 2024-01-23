// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:garbh/dashboards/parent_dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelecDatePage extends StatefulWidget {
  const SelecDatePage({Key? key}) : super(key: key);

  @override
  State<SelecDatePage> createState() => _SelecDatePageState();
}

class _SelecDatePageState extends State<SelecDatePage> {
  int selectedBabyAge = 1;

  Future<void> _saveDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedDateChild', "$selectedBabyAge");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const ParentDashboard(),
      ),
    );
  }

  void _showBabyAgeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Select Baby\'s Age'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<int>(
                value: selectedBabyAge,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      selectedBabyAge = value;
                    });
                    Navigator.of(context).pop();
                  }
                },
                items: List.generate(20, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text('${index + 1} months'),
                  );
                }),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
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
              "Select your baby's age",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 26.0),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showBabyAgeDialog(context),
                    child: Text('Baby\'s Age: $selectedBabyAge months'),
                  ),
                ),
              ],
            ),
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
