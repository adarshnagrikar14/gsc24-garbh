// ignore_for_file: library_private_types_in_public_api

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomizablePieChart extends StatefulWidget {
  final String title1;
  final double progress1;
  final double progress2;

  const CustomizablePieChart({
    required this.title1,
    required this.progress1,
    required this.progress2,
    Key? key,
  }) : super(key: key);

  @override
  _CustomizablePieChartState createState() => _CustomizablePieChartState();
}

class _CustomizablePieChartState extends State<CustomizablePieChart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sectionsSpace: 5,
              centerSpaceRadius: 15,
              sections: showingSections(),
              startDegreeOffset: 270,
              centerSpaceColor: Colors.red.shade50,
            ),
          ),
        ),
        Text(
          widget.title1,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        )
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    double p2 = widget.progress2 - widget.progress1;

    return [
      PieChartSectionData(
        color: Colors.red.shade400,
        value: widget.progress1,
        radius: 60,
        title: "${widget.progress1} ${p2 > 1000 ? "Cal" : "gm"}",
        titlePositionPercentageOffset: 0.6,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.grey, blurRadius: 2)],
        ),
      ),
      PieChartSectionData(
        color: Colors.red.shade200,
        value: p2,
        radius: 48,
        title: "",
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: [Shadow(color: Colors.grey, blurRadius: 2)],
        ),
      ),
    ];
  }
}
