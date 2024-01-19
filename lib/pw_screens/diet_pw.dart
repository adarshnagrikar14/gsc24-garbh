import 'package:flutter/material.dart';

class DietPagePregnantWomen extends StatefulWidget {
  const DietPagePregnantWomen({super.key});

  @override
  State<DietPagePregnantWomen> createState() => _DietPagePregnantWomenState();
}

class _DietPagePregnantWomenState extends State<DietPagePregnantWomen> {
  Color redColor = const Color.fromARGB(255, 249, 76, 102);

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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            //
          ],
        ),
      ),
    );
  }
}
