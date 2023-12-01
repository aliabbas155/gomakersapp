import 'package:flutter/material.dart';
import 'package:gomakersapp/LoginPage/login_page.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';

class BoardingScreenOne extends StatelessWidget {
  BoardingScreenOne({super.key});

  final pages = [
    //White Page
    Container(
      color: const Color(0xFF0A2D40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 80),
                  child: Text(
                    "G O M A K E R S",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Sora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SkipButton(),
              ],
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/cardhere.png",
              height: 300,
              width: 300, // Set the width as desired
            ),
          ),
          const Column(
            children: [
              Center(
                child: Text(
                  "Versatility and Templates",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Different types of ",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "Visual content",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Sora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'saving time and ensuring that',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'adhere to common design principles',
                  style: TextStyle(
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
    Container(
      color: const Color(0xFFA70101),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    "G O M A K E R S",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Sora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SkipButton(),
              ],
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/locationhere.png",
              height: 300,
              width: 300, // Set the width as desired
            ),
          ),
          const Column(
            children: [
              Center(
                child: Text(
                  "Geographical Context",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Including location",
                  style: TextStyle(
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "information on cards provides",
                style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Sora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'immediate context to the viewer',
                  style: TextStyle(
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Event Promotion',
                  style: TextStyle(
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ),
    //Orange Page
    Container(
      color: const Color(0xFFF18557),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    "G O M A K E R S",
                    style: TextStyle(
                      fontFamily: 'Sora-VariableFont_wght.ttf',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                SkipButton(),
              ],
            ),
          ),
          Center(
            child: Image.asset(
              "assets/images/videoediting.png",
              height: 300,
              width: 300, // Set the width as desired
            ),
          ),
          const Column(
            children: [
              Center(
                child: Text(
                  "User-Friendly Interface",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  "for video editing",
                  style: TextStyle(
                    fontSize: 22,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                "making it accessible to users",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Sora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'Once the video editing is complete',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    color: Colors.white,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'Simple Export and Sharing',
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Sora-VariableFont_wght.ttf',
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(child: GoToHomeButton()),
            ],
          )
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xFF92F3FF),
        body: LiquidSwipe(
      pages: pages,
      fullTransitionValue: 300,
      slideIconWidget: Lottie.asset(
        'assets/images/skip.json', // Replace with your LottieFiles animation file path
        width: 44, // You can customize the width
        height: 54, // You can customize the height
      ),
      positionSlideIcon: 0.5,
      enableLoop: false,
      waveType: WaveType.liquidReveal,
    ));
  }
}

//Class for Go To Home Button
class GoToHomeButton extends StatelessWidget {
  const GoToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: const Center(
            child: Text(
          'Start',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 21, color: Colors.green),
        )),
      ),
    );
  }
}

// Class for Skip Button
class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              FadeTransition(
            opacity: animation,
            child: const LoginScreen(),
          ),
          transitionDuration:
              const Duration(seconds: 1), // Set the transition duration here
        ));
      },
      child: const Padding(
        padding: EdgeInsets.only(left: 28),
        child: Text(
          'Skip',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
