import 'package:flutter/material.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  State<ParentDashboard> createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Hero(
        tag: "parentimage",
        child: ClipOval(
          child: Image.asset(
            "assets/images/parent.jpg",
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
