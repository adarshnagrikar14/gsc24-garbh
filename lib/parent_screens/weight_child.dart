import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeightChart extends StatefulWidget {
  const WeightChart({Key? key}) : super(key: key);

  @override
  State<WeightChart> createState() => _WeightChartState();
}

class _WeightChartState extends State<WeightChart> {
  List<DataPoint> dataPoints = [];
  List<FlSpot> weightSpots = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? serializedData = prefs.getStringList('weightDataPoints');
    if (serializedData != null) {
      setState(() {
        dataPoints = serializedData
            .map((jsonString) => DataPoint.fromJson(jsonString))
            .toList();
        weightSpots = _getWeightFlSpots();
      });
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> serializedData =
        dataPoints.map((dataPoint) => dataPoint.toJson()).toList();
    prefs.setStringList('weightDataPoints', serializedData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 214, 219),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 244, 244),
        title: const Text('Weight Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _showDataInputDialog(context),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 16.0),
              ),
              child: const Text('Enter Weight'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _showPreviousData(),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 16.0),
              ),
              child: const Text('View Previous Data'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (dataPoints.length >= 3) {
                  _showGraph();
                } else {
                  _showErrorDialog();
                }
              },
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 16.0),
              ),
              child: const Text('Analyze Data'),
            ),
            const SizedBox(height: 16.0),
            Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.blue, // Blue line color
                      ),
                      const SizedBox(width: 8),
                      const Text('Your child weight growth',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: Colors.red, // Red line color
                      ),
                      const SizedBox(width: 8),
                      const Text('Ideal baby\'s weight growth',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            if (weightSpots.isNotEmpty)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return LineChart(
                      LineChartData(
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          drawHorizontalLine: true,
                          verticalInterval: 1,
                          horizontalInterval: 20,
                          getDrawingHorizontalLine: (value) {
                            return FlLine(
                              color: const Color(0xff37434d),
                              strokeWidth: 0.5,
                            );
                          },
                          getDrawingVerticalLine: (value) {
                            return FlLine(
                              color: const Color(0xff37434d),
                              strokeWidth: 0.5,
                            );
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: const Color(0xff37434d),
                            width: 1,
                          ),
                        ),
                        minX: 0,
                        maxX: weightSpots.length.toDouble() - 1,
                        minY: 0,
                        maxY: _calculateMaxWeight().ceilToDouble(),
                        lineBarsData: [
                          LineChartBarData(
                            spots: weightSpots,
                            isCurved: true,
                            color: Colors.blue,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                            isStrokeCapRound: true,
                            barWidth: 6,
                          ),
                          LineChartBarData(
                            spots: _getRedGraphPoints(),
                            isCurved: true,
                            color: Colors.red,
                            dotData: FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                            isStrokeCapRound: true,
                            barWidth: 6,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getRedGraphPoints() {
    return [
      FlSpot(0, 3.2), // Week 1
      FlSpot(1, 3.8), // Week 2
      FlSpot(2, 4.5), // Week 3
      FlSpot(3, 5.1), // Week 4
      FlSpot(4, 5.9), // Week 5
      FlSpot(5, 6.5), // Week 6
    ];
  }

  double _calculateMaxWeight() {
    double maxWeight = 0;
    for (int i = 0; i < dataPoints.length; i++) {
      if (dataPoints[i].weight > maxWeight) {
        maxWeight = dataPoints[i].weight;
      }
    }
    return maxWeight;
  }

  List<FlSpot> _getWeightFlSpots() {
    return List.generate(
      dataPoints.length,
      (index) => FlSpot(index.toDouble(), dataPoints[index].weight),
    );
  }

  void _showDataInputDialog(BuildContext context) {
    double? weight;
    int? weeks;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Weight'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Weight (in kg)'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    weight = double.tryParse(value);
                  }
                },
              ),
              TextField(
                decoration: const InputDecoration(
                    labelText: 'Enter Weeks (e.g., week1)'),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    final numericValue =
                        int.tryParse(value.replaceAll(RegExp(r'[^0-9]'), ''));
                    weeks = numericValue ?? 0;
                  }
                },
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (weight != null && weeks != null) {
                  setState(() {
                    dataPoints.add(DataPoint(
                      weight: weight!,
                      weeks: weeks!,
                    ));
                  });
                  Navigator.pop(context);
                  _saveData();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: const Text('Please enter at least three sets of data.'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showGraph() {
    dataPoints.sort((a, b) => a.weeks.compareTo(b.weeks));

    for (int i = 0; i < dataPoints.length; i++) {
      print(
          'DataPoint $i - Weeks: ${dataPoints[i].weeks}, Weight: ${dataPoints[i].weight}');
    }
    setState(() {
      weightSpots = _getWeightFlSpots();
    });
    _saveData();
  }

  void _showPreviousData() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Previous Data'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: dataPoints
                .map((dataPoint) => ListTile(
                      title: Text(
                          'Weeks: ${dataPoint.weeks}, Weight: ${dataPoint.weight}'),
                    ))
                .toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

class DataPoint {
  final double weight;
  final int weeks;

  DataPoint({required this.weight, required this.weeks});

  factory DataPoint.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return DataPoint(
      weight: json['weight'],
      weeks: json['weeks'],
    );
  }

  String toJson() {
    return jsonEncode({
      'weight': weight,
      'weeks': weeks,
    });
  }
}
