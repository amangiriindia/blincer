import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/common_function.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Initial delay before checking login status
    await Future.delayed(const Duration(seconds: 2));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');

    // Navigate based on the login status
    if (isLoggedIn == true) {
      CommonFunction.showLoadingDialog(context);
      await Future.delayed(const Duration(seconds: 1));
      CommonFunction.hideLoadingDialog(context);
      // Show loading dialog
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => OnBoardingScreen(
                  onDone: () {},
                )),
        (Route<dynamic> route) => false,
      );
    } else {
      CommonFunction.showLoadingDialog(context);
      await Future.delayed(const Duration(seconds: 1));
      CommonFunction.hideLoadingDialog(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => OnBoardingScreen(
                  onDone: () {},
                )),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo.jpeg',
              width: 120, // Set the specific width
              height: 120, // Set the specific height
            ),
          ),
        ],
      ),
    );
  }
}
