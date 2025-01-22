import 'package:blinker/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../constant/app_color.dart';
import 'login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  final VoidCallback onDone;
  const OnBoardingScreen({super.key, required this.onDone});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  bool showGetStartedButton = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page?.round() == 5) {
        setState(() => showGetStartedButton = true);
      } else {
        setState(() => showGetStartedButton = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          controller: _controller,
          children: [
            _buildOnboardingPage(
              'Welcome to Blincer!',
              'assets/anim/anim-1.json', // Local path for the animation
              'Your ultimate destination for all your shopping needs.',
            ),
            _buildOnboardingPage(
              'Shop with Ease',
              'assets/anim/anim-2.json', // Local path for the animation
              'Browse through categories and find exactly what you need.',
            ),
            _buildOnboardingPage(
              'Explore a Variety of Products',
              'assets/anim/anim-3.json', // Local path for the animation
              'From electronics to fashion, we have it all.',
            ),
            _buildOnboardingPage(
              'Exclusive Deals and Discounts',
              'assets/anim/anim-4.json', // Local path for the animation
              'Get the best value for your money with our offers.',
            ),
            _buildOnboardingPage(
              'Secure Checkout',
              'assets/anim/anim-5.json', // Local path for the animation
              'Enjoy a safe and smooth payment process.',
            ),
            _buildOnboardingPage(
              'Fast Delivery',
              'assets/anim/anim-6.json', // Local path for the animation
              'Get your orders delivered quickly and reliably.',
            ),
          ],
        ),
        if (showGetStartedButton)
          Align(
            alignment: const Alignment(0, 0.75),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: AnimatedOpacity(
                opacity: showGetStartedButton ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: ButtonCustom(
                  callback: () {
                    widget.onDone();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  title: "Get Started",
                  gradient: const LinearGradient(colors: [
                    AppColor.primary,
                    AppColor.secondary,
                  ]),
                ),
              ),
            ),
          ),
        Container(
          alignment: const Alignment(0, 0.9),
          child: SmoothPageIndicator(
            controller: _controller,
            count: 6, // Update the count to 6
            effect:
                const JumpingDotEffect(activeDotColor: AppColor.primarySoft),
          ),
        ),
      ]),
    );
  }

  Widget _buildOnboardingPage(
      String title, String imagePath, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(imagePath,
              height: 400,
              width: 800,
              fit: BoxFit.contain), // Use Lottie.asset for local files
          Text(title,
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Text(description,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
