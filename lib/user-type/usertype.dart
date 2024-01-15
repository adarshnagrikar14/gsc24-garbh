import 'package:garbh/reusables/roundbutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserTypePage extends StatefulWidget {
  const UserTypePage({super.key});

  @override
  State<UserTypePage> createState() => _UserTypePageState();
}

class _UserTypePageState extends State<UserTypePage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select one"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 18.0,
              left: 15.0,
            ),
            child: Text(
              "I am a ",
              style: TextStyle(
                fontSize: 18.0,
              ),
            ),
          ),
          RoundedButton(
            text: 'Click Me',
            onTap: () {},
          )
        ],
      ),
    );
  }
}
