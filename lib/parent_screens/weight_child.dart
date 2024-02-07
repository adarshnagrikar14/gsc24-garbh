import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataPoint {
  final double weight;
  final double height;
  final int weeks;

  DataPoint({
    required this.weight,
    required this.height,
    required this.weeks,
  });

  Map<String, dynamic> toJson() {
    return {
      'weight': weight,
      'height': height,
      'weeks': weeks,
    };
  }

  static DataPoint fromJson(Map<String, dynamic> json) {
    return DataPoint(
      weight: json['weight'],
      height: json['height'],
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

class BoysWeight extends StatefulWidget {
  const BoysWeight({Key? key}) : super(key: key);

  @override
  State<BoysWeight> createState() => _BoysWeightState();
}

class _BoysWeightState extends State<BoysWeight> {
  List<DataPoint> dataPoints = [];
  List<FlSpot> weightSpots = [];
  final String dataKeyBoys = 'boys_weight_chart_data';

  String selectedGender = 'Boy';

  @override
  void initState() {
    super.initState();
    if (dataPoints.isEmpty) {
      _loadDataBoys();
    }
  }

  @override
  void dispose() {
    _saveDataBoys();
    super.dispose();
  }

  Future<void> _loadDataBoys() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(dataKeyBoys);

    if (jsonData != null) {
      setState(() {
        dataPoints = DataPointsListExtension.fromJsonList(jsonData);
        weightSpots = _getWeightFlSpots();
      });
    }
  }

  Future<void> _saveDataBoys() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = DataPointsListExtension(dataPoints).toJsonList();
    prefs.setString(dataKeyBoys, jsonData);
  }

  List<FlSpot> _getRedGraphPoints() {
    return [
      FlSpot(0, 0),
      FlSpot(1, 49.5),
      FlSpot(2, 50.8),
      FlSpot(3, 52.1),
      FlSpot(4, 54.6),
      FlSpot(5, 56.5),
      FlSpot(6, 58.0),
    ];
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
                    const InputDecoration(labelText: 'Enter Weight(in kg)'),
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
                      height: 0,
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
          'DataPoint $i - Weeks: ${dataPoints[i].weeks}, Weight: ${dataPoints[i].weight}');
    }
    setState(() {
      weightSpots = _getWeightFlSpots();
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
                .map(
                  (dataPoint) => ListTile(
                    title: Text(
                      'Weeks: ${dataPoint.weeks}, Weight: ${dataPoint.weight}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteDataPoint(dataPoint);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
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

  void _deleteDataPoint(DataPoint dataPoint) {
    setState(() {
      dataPoints.remove(dataPoint);
      weightSpots = _getWeightFlSpots();
    });
  }

  void _navigateToGirlsWeight() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => GirlsWeight()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 214, 219),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 244, 244),
        title: const Text('Boy Baby Weight Chart'),
        actions: [
          DropdownButton<String>(
            value: selectedGender,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedGender = newValue;
                });
                if (newValue == 'Girl') {
                  _navigateToGirlsWeight();
                }
              }
            },
            items: <String>['Boy', 'Girl'].map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ],
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
                        color: Colors.blue,
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
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const Text('Ideal baby\'s weight growth',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (weightSpots.isNotEmpty)
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
                        maxX: weightSpots.length.toDouble() - 1,
                        minY: 0,
                        maxY: 200,
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
}

class GirlsWeight extends StatefulWidget {
  const GirlsWeight({Key? key}) : super(key: key);

  @override
  State<GirlsWeight> createState() => _GirlsWeightState();
}

class _GirlsWeightState extends State<GirlsWeight> {
  List<DataPoint> dataPoints = [];
  List<FlSpot> weightSpots = [];
  final String dataKeyGirls = 'girls_weight_chart_data'; // Corrected dataKey

  @override
  void initState() {
    super.initState();
    if (dataPoints.isEmpty) {
      _loadDataGirls();
    }
  }

  @override
  void dispose() {
    _saveDataGirls();
    super.dispose();
  }

  Future<void> _loadDataGirls() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(dataKeyGirls); // Corrected dataKey

    if (jsonData != null) {
      setState(() {
        dataPoints = DataPointsListExtension.fromJsonList(jsonData);
        weightSpots = _getWeightFlSpots();
      });
    }
  }

  Future<void> _saveDataGirls() async {
    if (dataPoints.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      final jsonData = DataPointsListExtension(dataPoints).toJsonList();
      prefs.setString(dataKeyGirls, jsonData); // Corrected dataKey
    }
  }

  List<FlSpot> _getRedGraphPoints() {
    return [
      FlSpot(0, 0),
      FlSpot(1, 49.5),
      FlSpot(2, 50.8),
      FlSpot(3, 52.1),
      FlSpot(4, 54.6),
      FlSpot(5, 56.5),
      FlSpot(6, 58.0),
    ];
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
                    const InputDecoration(labelText: 'Enter Weight(in kg)'),
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
                      height: 0,
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

    for (int i = 0; dataPoints.length > 0 && i < dataPoints.length; i++) {
      print(
          'DataPoint $i - Weeks: ${dataPoints[i].weeks}, Weight: ${dataPoints[i].weight}');
    }
    setState(() {
      weightSpots = _getWeightFlSpots();
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
                .map(
                  (dataPoint) => ListTile(
                    title: Text(
                      'Weeks: ${dataPoint.weeks}, Weight: ${dataPoint.weight}',
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteDataPoint(dataPoint);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
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

  void _deleteDataPoint(DataPoint dataPoint) {
    setState(() {
      dataPoints.remove(dataPoint);
      weightSpots = _getWeightFlSpots();
    });
  }

  void _navigateToBoysWeight() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BoysWeight()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 214, 219),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 253, 244, 244),
        title: const Text('Girl Baby Weight Chart'),
        actions: [
          DropdownButton<String>(
            value: 'Girl',
            onChanged: (String? newValue) {
              if (newValue != null) {
                if (newValue == 'Boy') {
                  _navigateToBoysWeight();
                }
              }
            },
            items: <String>['Girl', 'Boy'].map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ],
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
                        color: Colors.blue,
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
                        color: Colors.red,
                      ),
                      const SizedBox(width: 8),
                      const Text('Ideal baby\'s weight growth',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (weightSpots.isNotEmpty)
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
                        maxX: weightSpots.length.toDouble() - 1,
                        minY: 0,
                        maxY: 200,
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
}
