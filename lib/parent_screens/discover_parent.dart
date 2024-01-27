import 'package:flutter/material.dart';

class ParentDiscoverScreen extends StatefulWidget {
  const ParentDiscoverScreen({super.key});

  @override
  State<ParentDiscoverScreen> createState() => _ParentDiscoverScreenState();
}

class _ParentDiscoverScreenState extends State<ParentDiscoverScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Parenting tips?...",
              style: TextStyle(fontSize: 25.0),
            ),
          )
        ],
      ),
    );
  }
}
