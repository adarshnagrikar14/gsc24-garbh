import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample3 extends StatefulWidget {
  const PieChartSample3({super.key});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: PieChart(
        PieChartData(
          sectionsSpace: 5,
          centerSpaceRadius: 20,
          sections: showingSections(),
          centerSpaceColor: Colors.red.shade50,
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      const shadows = [Shadow(color: Colors.grey, blurRadius: 2)];
      const radius = 120.0;
      const fontSize = 16.0;
      const widgetSize = 50.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red.shade400,
            value: 39,
            title: '39%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: const _Badge(
              'assets/images/apple.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red.shade200,
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: const _Badge(
              'assets/images/strawberry.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.pink.shade400,
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: const _Badge(
              'assets/images/lime.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.pink.shade200,
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: const TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: shadows,
            ),
            badgeWidget: const _Badge(
              'assets/images/grape.png',
              size: widgetSize,
              borderColor: Colors.black,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception("Exception");
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        seconds: 3,
      ),
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.red.withOpacity(.4),
            offset: const Offset(3, 3),
            blurRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * 0.1),
      child: Center(
        child: Image(
          image: AssetImage(
            svgAsset,
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
