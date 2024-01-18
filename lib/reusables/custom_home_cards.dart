import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String imageName;
  final String text;

  const CustomCard({super.key, required this.imageName, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      height: 220.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
      child: Card(
        elevation: 4.0,
        child: Column(
          children: [
            Image.asset(
              "assets/images/$imageName",
              height: 140.0,
              width: 130.0,
              fit: BoxFit.fitHeight,
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                    color: Colors.grey.shade700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
