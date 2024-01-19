import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:gap/gap.dart';

class DietPagePregnantWomen extends StatefulWidget {
  const DietPagePregnantWomen({super.key});

  @override
  State<DietPagePregnantWomen> createState() => _DietPagePregnantWomenState();
}

class _DietPagePregnantWomenState extends State<DietPagePregnantWomen> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

  late String title = "Breakfast";
  late int cardPosition = 0;

  final List<String> carouselItems = [
    "Breakfast",
    "Lunch",
    "Snacks",
    "Dinner",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Diet Schedule",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: redColor,
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //
              Card(
                elevation: 2.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      12.0,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/progress_track.png",
                        width: 90.0,
                      ),
                      const Gap(12.0),
                      Expanded(
                        child: Text(
                          "Keep track of your Diet here. Select the options you consumed under specific tabs.",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      const Gap(5.0),
                    ],
                  ),
                ),
              ),

              const Gap(20.0),
              //
              Text(
                "\t$title",
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(20.0),

              //
              CarouselSlider(
                options: CarouselOptions(
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  enlargeFactor: 1.5,
                  viewportFraction: 1,
                  aspectRatio: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      title = carouselItems[index];
                      cardPosition = index;
                    });
                  },
                ),
                items: carouselItems.map((item) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Card(
                        elevation: 2.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 220.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Center(
                            child: PieChartSample2(
                              title: carouselItems[cardPosition],
                              cardPosition: cardPosition,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
      child: PieChart(
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
    );
  }

  List<PieChartSectionData> showingSections() {
    int cardPos = widget.cardPosition;

    return List.generate(4, (i) {
      const radius = 20.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.blue,
            value: 20,
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
            color: Colors.yellow,
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
                    child: Text("${widget.title} 40%"),
                  )
                : const Center(),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.purple,
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
                    child: Text("${widget.title} 10%"),
                  )
                : const Center(),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
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

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
