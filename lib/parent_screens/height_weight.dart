import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';

class HeightChart extends StatefulWidget {
  const HeightChart({Key? key}) : super(key: key);

  @override
  State<HeightChart> createState() => _HeightChartState();
}

class _HeightChartState extends State<HeightChart> {
  List<DataPoint> dataPoints = [];
  List<FlSpot> heightSpots = [];
  List<FlSpot> weightSpots = [];
  List<String> imageUrls = [];
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  @override
  void initState() {
    super.initState();

    fetchImageUrls();
  }

  void fetchImageUrls() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("HWimages").get();

    for (var document in querySnapshot.docs) {
      var data = document.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('imageUrl')) {
        setState(() {
          imageUrls.add(data['imageUrl']);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Meditation",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: redColor,
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
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
              child: const Text('Enter Height and Weight'),
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
            const SizedBox(height: 30.0),
            if (heightSpots.isNotEmpty && weightSpots.isNotEmpty)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return LineChart(
                      LineChartData(
                        gridData: const FlGridData(
                          show: false,
                        ),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: const AxisTitles(),
                          topTitles: const AxisTitles(),
                          leftTitles: AxisTitles(
                            axisNameSize: 20.0,
                            sideTitles: SideTitles(
                              showTitles: true,
                              // interval: 1,
                              getTitlesWidget: (value, meta) {
                                return Text("$value");
                              },
                              reservedSize: 50.0,
                            ),
                          ),
                        ),
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
                        maxY: 150,
                        lineBarsData: [
                          LineChartBarData(
                            spots: heightSpots,
                            isCurved: true,
                            color: Colors.blue,
                            show: true,
                            dotData: const FlDotData(show: false),
                            belowBarData: BarAreaData(show: false),
                            isStrokeCapRound: true,
                            barWidth: 6,
                          ),
                          LineChartBarData(
                            spots: weightSpots,
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
            const Gap(20.0),
          ],
        ),
      ),
    );
  }

  List<FlSpot> _getHeightFlSpots() {
    return List.generate(dataPoints.length,
        (index) => FlSpot(index.toDouble(), dataPoints[index].height));
  }

  List<FlSpot> _getWeightFlSpots() {
    return List.generate(dataPoints.length,
        (index) => FlSpot(index.toDouble(), dataPoints[index].weight));
  }

  void _showDataInputDialog(BuildContext context) {
    double? height;
    double? weight;
    int? weeks;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Enter Height and Weight'),
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
                decoration:
                    const InputDecoration(labelText: 'Enter Weight(in kgs)'),
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
                if (height != null && weight != null && weeks != null) {
                  setState(() {
                    dataPoints.add(DataPoint(
                      height: height!,
                      weight: weight!,
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
          'DataPoint $i - Weeks: ${dataPoints[i].weeks}, Height: ${dataPoints[i].height}, Weight: ${dataPoints[i].weight}');
    }
    setState(() {
      heightSpots = _getHeightFlSpots();
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: dataPoints
                .map(
                  (dataPoint) => ListTile(
                    title: Text(
                        'Weeks: ${dataPoint.weeks}, Height: ${dataPoint.height}, Weight: ${dataPoint.weight}'),
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
}

class DataPoint {
  final double height;
  final double weight;
  final int weeks;

  DataPoint({required this.height, required this.weight, required this.weeks});
}
