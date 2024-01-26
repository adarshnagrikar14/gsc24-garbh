import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CustomExercisePieChart extends StatelessWidget {
  final double totalExerciseCalBurn;

  const CustomExercisePieChart({Key? key, required this.totalExerciseCalBurn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.12,
      child: PieChart(
        PieChartData(
          sectionsSpace: 5,
          centerSpaceRadius: 15,
          sections: showingSections2(),
          startDegreeOffset: 271,
          centerSpaceColor: Colors.red.shade50,
        ),
        swapAnimationCurve: Curves.bounceIn,
      ),
    );
  }

  List<PieChartSectionData> showingSections2() {
    final double progress2 = 100 - totalExerciseCalBurn / 1;

    return [
      PieChartSectionData(
        color: Colors.pink.shade300,
        value: totalExerciseCalBurn / 1,
        radius: 50,
        title: "",
        titlePositionPercentageOffset: 0.8,
      ),
      PieChartSectionData(
        color: Colors.pink.shade200,
        value: progress2,
        radius: 38,
        titlePositionPercentageOffset: 0.4,
        title: "$totalExerciseCalBurn Cal.",
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
