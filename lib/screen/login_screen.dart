import 'package:blinker/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import '../constant/app_color.dart';
import 'base/button_nav_bar.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailPhoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
  setState(() {
    _isLoading = true;
  });

  final emailPhone = _emailPhoneController.text.trim();
  final password = _passwordController.text.trim();

  if (emailPhone.isEmpty || password.isEmpty) {
    Fluttertoast.showToast(
      msg: "Please enter valid credentials",
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
    setState(() {
      _isLoading = false;
    });
    return;
  }

  try {
    final authService = AuthService();
    final result = await authService.loginUser(emailPhone, password);

    // If login is successful
    if (result['success']) {
      Fluttertoast.showToast(
        msg: result['message'], // Display success message
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      // Navigate to the next screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavBar(),
        ),
      );
    }else if(!result['success']){
Fluttertoast.showToast(
        msg: result['message'], // Display success message
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  } catch (e) {
    // Show error message returned from API
    Fluttertoast.showToast(
      msg: e.toString().replaceFirst("Exception: ", ""), // Clean up the message
      backgroundColor: Colors.red,
      textColor: Colors.white,
    );
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Gradient background with Lottie animation
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primary, AppColor.secondary],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  ),
                ),
                child: Column(
                  children: [
                    Lottie.asset(
                      'assets/anim/anim_2.json',
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Login Form
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    // Email/Phone Number Input Field
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.person, color: AppColor.primary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _emailPhoneController,
                                keyboardType: TextInputType.emailAddress,
                                style: const TextStyle(fontSize: 16),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your phone number or email",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password Input Field
                    Material(
                      elevation: 2,
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColor.primary,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lock, color: AppColor.primary),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextField(
                                controller: _passwordController,
                                obscureText: true,
                                style: const TextStyle(fontSize: 16),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Forgot Password Text
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          // Add forgot password functionality here
                        },
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Login Button
                    GestureDetector(
                      onTap: _isLoading ? null : _login,
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppColor.primary, AppColor.secondary],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: _isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white)
                              : const Text(
                                  "Login",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Don't have an account? Register
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account? ",
                            style: TextStyle(fontSize: 14, color: Colors.grey)),
                        GestureDetector(
                          onTap: () {
                            // Navigate to registration screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColor.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
