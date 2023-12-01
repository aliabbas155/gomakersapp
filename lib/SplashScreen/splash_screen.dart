import 'package:flutter/material.dart';
import 'package:gomakersapp/BoardingScreen/onboardingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  final List<Color> textColors = [
    Colors.purple,
    Colors.blue,
    Colors.yellow,
    Colors.red,
  ];
  int currentColorIndex = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Slower duration (10 seconds)
      vsync: this,
    );

    _controller.repeat(reverse: true);

    // Add a delay of 5 seconds and navigate to the next screen
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: BoardingScreenOne(),
        ),
        transitionDuration:
            const Duration(seconds: 1), // Set the transition duration here
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color getNextTextColor() {
    final color = textColors[currentColorIndex];
    currentColorIndex = (currentColorIndex + 1) % textColors.length;
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Column(
          children: <Widget>[
            Image.asset(
              'assets/images/logo.png',
              width: 400,
              height: 450,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Row(
                children: <Widget>[
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Center(
                          child: Text(
                            'GoMaker',
                            style: TextStyle(
                              fontSize: 26,
                              fontFamily:
                                  'NotoSerif-VariableFont_wdth,wght.ttf',
                              fontWeight: FontWeight.bold,
                              color: Color.lerp(
                                getNextTextColor(),
                                getNextTextColor(),
                                _controller.value,
                              )!,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Business Card Designing App',
                    style: TextStyle(
                      fontFamily: 'NotoSerif-VariableFont_wdth,wght.ttf',
                      fontSize: 22,
                      color: Color.lerp(
                        getNextTextColor(),
                        getNextTextColor(),
                        _controller.value,
                      )!,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
