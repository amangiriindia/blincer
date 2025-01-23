import 'package:blinker/constant/user_constant.dart';
import 'package:flutter/material.dart';
import '../constant/common_function.dart';
import 'base/button_nav_bar.dart';
import 'on_boarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

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
    // Initial delay to show splash screen logo
    await Future.delayed(const Duration(seconds: 2));

    // Show loading dialog
    CommonFunction.showLoadingDialog(context);

    // Simulate additional delay for processing (if needed)
    await Future.delayed(const Duration(seconds: 1));

    // Hide loading dialog
    CommonFunction.hideLoadingDialog(context);
    print("User token ${UserConstant.TOKEN}");
    // Navigate based on login status
    if (UserConstant.TOKEN != null) {
      // Navigate to BottomNavBar if logged in
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => BottomNavBar()),
        (Route<dynamic> route) => false,
      );
    } else {
      // Navigate to OnBoardingScreen if not logged in
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => OnBoardingScreen(
            onDone: () {
            },
          ),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/logo.jpeg',
          width: 120,
          height: 120,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
