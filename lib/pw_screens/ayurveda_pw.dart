import 'package:flutter/material.dart';
import 'package:garbh/data/ayurveda_data.dart';
import 'package:garbh/reusables/custom_ayurved_cards.dart';
import 'package:url_launcher/url_launcher.dart';

class AyurvedaPage extends StatefulWidget {
  const AyurvedaPage({super.key});

  @override
  State<AyurvedaPage> createState() => _AyurvedaPageState();
}

class _AyurvedaPageState extends State<AyurvedaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ayurveda",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 249, 76, 102),
        toolbarHeight: 60.0,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: ayurvedaDatas.length,
          itemBuilder: (context, index) {
            var ayurvedaData = ayurvedaDatas[index].values.first;
            return CustomCard(
              imageUrl: ayurvedaData[2],
              title: ayurvedaData[0],
              channelName: "Garbh Community",
              url: ayurvedaData[1],
              onTap: () async {
                if (!await launchUrl(
                  Uri.parse(ayurvedaData[1]),
                  mode: LaunchMode.externalApplication,
                )) {
                  throw Exception('Could not launch ${ayurvedaData[1]}');
                }
              },
            );
          },
        ),
      ),
    );
  }
}
