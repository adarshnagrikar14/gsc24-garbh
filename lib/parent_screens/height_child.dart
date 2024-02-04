import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HeightChart extends StatefulWidget {
  const HeightChart({Key? key}) : super(key: key);

  @override
  State<HeightChart> createState() => _HeightChartState();
}

class _HeightChartState extends State<HeightChart> {
  List<DataPoint> dataPoints = [];
  List<FlSpot> heightSpots = [];
  final String dataKey = 'height_chart_data';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _saveData();
    super.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(dataKey);

    if (jsonData != null) {
      setState(() {
        dataPoints = DataPointsListExtension.fromJsonList(jsonData);
        heightSpots = _getHeightFlSpots();
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = DataPointsListExtension(dataPoints).toJsonList();
    prefs.setString(dataKey, jsonData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 214, 219),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 253, 244, 244),
        title: const Text('Height Chart'),
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
                textStyle: const TextStyle(fontSize: 16.0),
              ),
              child: const Text('Enter Height'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _showPreviousData(),
              style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 16.0),
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
                textStyle: const TextStyle(fontSize: 16.0),
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
                      const Text('Your child height growth',
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
                      const Text('Ideal baby\'s height growth',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (heightSpots.isNotEmpty)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return LineChart(
                      LineChartData(
                        gridData: const FlGridData(
                            show: true, drawVerticalLine: true),
                        borderData: FlBorderData(
                          show: true,
                          border: Border.all(
                            color: const Color(0xff37434d),
                            width: 1,
                          ),
                        ),
                        minX: 0,
                        maxX: heightSpots.length.toDouble() - 1,
                        minY: 0,
                        maxY: 200,
                        lineBarsData: [
                          LineChartBarData(
                            spots: heightSpots,
                            isCurved: true,
                            color: Colors.blue,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                            isStrokeCapRound: true,
                            barWidth: 6,
                          ),
                          // Red graph (hardcoded data)
                          LineChartBarData(
                            spots: _getRedGraphPoints(),
                            isCurved: true,
                            color: Colors.red,
                            dotData: const FlDotData(show: false),
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
    List<FlSpot> flSpot = [
      const FlSpot(0, 0),
      const FlSpot(1, 40.0),
      const FlSpot(2, 50.8),
      const FlSpot(3, 52.1),
      const FlSpot(4, 54.6),
      const FlSpot(4, 54.6),
      const FlSpot(5, 56.5),
      const FlSpot(6, 58.0),
    ];

    return flSpot.sublist(0, dataPoints.length);
  }

  List<FlSpot> _getHeightFlSpots() {
    return List.generate(
      dataPoints.length,
      (index) => FlSpot(index.toDouble(), dataPoints[index].height),
    );
  }

  void _showDataInputDialog(BuildContext context) {
    double? height;
    int? weeks;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Height'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:
                    const InputDecoration(labelText: 'Enter Height(in cm)'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    height = double.tryParse(value);
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
                if (height != null && weeks != null) {
                  setState(() {
                    dataPoints.add(DataPoint(
                      height: height!,
                      weight: 0, // Set weight to 0 or any default value
                      weeks: weeks!,
                    ));
                  });
                  Navigator.pop(context);
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
          'DataPoint $i - Weeks: ${dataPoints[i].weeks}, Height: ${dataPoints[i].height}');
    }
    setState(() {
      heightSpots = _getHeightFlSpots();
    });
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
                          'Weeks: ${dataPoint.weeks}, Height: ${dataPoint.height}'),
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
  final double height;
  final double weight;
  final int weeks;

  DataPoint({
    required this.height,
    required this.weight,
    required this.weeks,
  });

  Map<String, dynamic> toJson() {
    return {
      'height': height,
      'weight': weight,
      'weeks': weeks,
    };
  }

  static DataPoint fromJson(Map<String, dynamic> json) {
    return DataPoint(
      height: json['height'],
      weight: json['weight'],
      weeks: json['weeks'],
    );
  }
}

extension DataPointsListExtension on List<DataPoint> {
  String toJsonList() {
    final List<Map<String, dynamic>> dataList =
        map((dataPoint) => dataPoint.toJson()).toList();
    return json.encode(dataList);
  }

  static List<DataPoint> fromJsonList(String jsonList) {
    final List<dynamic> dataList = json.decode(jsonList);
    return dataList.map((json) => DataPoint.fromJson(json)).toList();
  }
}
