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
  await Future.delayed(const Duration(seconds: 2));

  CommonFunction.showLoadingDialog(context);
  await Future.delayed(const Duration(seconds: 1));

  // Load user data
  await UserConstant.loadUserData();

  CommonFunction.hideLoadingDialog(context);

  print("User token: ${UserConstant.TOKEN}");
  if (UserConstant.TOKEN != null) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => BottomNavBar()),
      (Route<dynamic> route) => false,
    );
  } else {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => OnBoardingScreen(
          onDone: () {},
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
