import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartSample2 extends StatefulWidget {
  final String title;
  final int cardPosition;

  const PieChartSample2({
    super.key,
    required this.title,
    required this.cardPosition,
  });

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 5,
              centerSpaceRadius: 50,
              startDegreeOffset: widget.cardPosition == 0
                  ? 270
                  : widget.cardPosition == 1
                      ? 180
                      : 0,
              sections: showingSections(),
            ),
          ),
          Center(
            child: Text(
              widget.cardPosition == 0
                  ? "400 Cal."
                  : widget.cardPosition == 1
                      ? "600 Cal."
                      : widget.cardPosition == 2
                          ? "250 Cal."
                          : "600 Cal.",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    int cardPos = widget.cardPosition;

    return List.generate(4, (i) {
      const radius = 20.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red.shade400,
            title: "",
            radius: cardPos == 0 ? 28.0 : radius,
            badgePositionPercentageOffset: 2,
            badgeWidget: cardPos == 0
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 20%"),
                  )
                : const Center(),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.red.shade200,
            value: 40,
            title: "",
            radius: cardPos == 1 ? 28.0 : radius,
            badgePositionPercentageOffset: 1.5,
            badgeWidget: cardPos == 1
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 35%"),
                  )
                : const Center(),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.pink.shade400,
            value: 10,
            title: "",
            radius: cardPos == 2 ? 28.0 : radius,
            badgePositionPercentageOffset: 1.5,
            badgeWidget: cardPos == 2
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 15%"),
                  )
                : const Center(),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.pink.shade200,
            value: 30,
            title: "",
            radius: cardPos == 3 ? 28.0 : radius,
            badgePositionPercentageOffset: 1.5,
            badgeWidget: cardPos == 3
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        50.0,
                      ),
                      border: Border.all(),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text("${widget.title} 30%"),
                  )
                : const Center(),
          );
        default:
          throw Error();
      }
    });
  }
}
