// ignore_for_file: use_build_context_synchronously

import 'package:garbh/user-type/usertype.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _authFirebase = FirebaseAuth.instance;

  Future<void> signup(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result =
          await _authFirebase.signInWithCredential(authCredential);

      // ignore: unnecessary_null_comparison
      if (result != null) {
        Fluttertoast.showToast(
          msg: "Login Successful",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const UserTypePage(),
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error occurred",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }

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
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/raw/login_welcome.json",
            width: MediaQuery.of(context).size.width * 0.8,
            repeat: false,
          ),
          const Text(
            "SIGN UP\nTo continue with Garbh",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              bottom: 30.0,
            ),
            child: ElevatedButton(
              onPressed: () => signup(context),
              style: ElevatedButton.styleFrom(
                elevation: 2.0,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: SizedBox(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.7,
                child: const Center(
                  child: Text(
                    'Continue Signup',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 25.0,
              right: 25.0,
              top: 10.0,
            ),
            child: Text(
              "Login/ Sign up with a specific Google account to continue with the application.\n",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
