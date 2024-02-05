import 'package:flutter/material.dart';

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
    );
  }
}
