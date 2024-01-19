import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CustomInfoCard extends StatelessWidget {
  final String imageAsset;
  final int concDays;

  const CustomInfoCard(
      {Key? key, required this.imageAsset, required this.concDays})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String getImageNameForDays(int days) {
      Map<int, String> developmentalStages = {
        105: "apple.png",
        112: "avocado.png",
        126: "bell_pepper.png",
        168: "ear_of_corn.png",
        77: "fig.png",
        63: "grape.png",
        133: "heirloom_tomato.png",
        56: "kidney_bean.png",
        70: "kumquat.png",
        42: "lentil.png",
        84: "lime.png",
        231: "pineapple.png",
        28: "poppy_seed.png",
        175: "rutabaga.png",
        35: "sesame_seed.png",
        119: "turnip.png",
        273: "watermelon.png"
      };

      if (days < 28) {
        return developmentalStages[28] ?? "unknown.png";
      } else {
        int nearestSmallerDay = developmentalStages.keys
            .where((element) => element <= days)
            .reduce((a, b) => a > b ? a : b);

        return developmentalStages[nearestSmallerDay] ?? "unknown.png";
      }
    }

    String getDevelopmentalStageForDays(int days) {
      Map<int, String> developmentalStages = {
        105: "Apple",
        112: "Avocado",
        126: "Bell pepper",
        168: "Ear of corn",
        77: "Fig",
        63: "Grape",
        133: "Heirloom Tomato",
        56: "Kidney Bean",
        70: "Kumquat",
        42: "Lentil",
        84: "Lime",
        231: "Pineapple",
        28: "Poppy Seed",
        175: "Rutabaga",
        35: "Sesame Seed",
        119: "Turnip",
        273: "Watermelon"
      };

      if (days < 28) {
        return "Your fetus will be the size of a ${developmentalStages[28]} by 28 days.";
      } else {
        int nearestSmallerDay = developmentalStages.keys
            .where((element) => element <= days)
            .reduce((a, b) => a > b ? a : b);

        String result =
            "Your fetus is the size of a ${developmentalStages[nearestSmallerDay]} at $days Days.";

        return result;
      }
    }

    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.only(
        top: 10.0,
      ),
      color: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.red.shade100,
            width: 1.0,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.red.shade100,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                "$imageAsset/${getImageNameForDays(concDays)}",
                width: 100.0,
                height: 100.0,
              ),
            ),
            const Gap(15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Check out 💡",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    getDevelopmentalStageForDays(concDays),
                    style: const TextStyle(
                      fontSize: 16.5,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "More Details",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
