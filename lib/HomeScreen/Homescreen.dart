import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomakersapp/CustomizeBusninessCards/ShowallCustomizeBC.dart';
import 'package:gomakersapp/Drawer/businessdrawer.dart';
import 'package:gomakersapp/Drawer/showallcards.dart';
import 'package:gomakersapp/Otherbusiness/otherbusniess.dart';
import 'package:gomakersapp/QR_Scanner/QRScanner.dart';
import 'package:gomakersapp/RateUs/customerrating.dart';
import 'package:gomakersapp/VideoEdit/videoediting.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;
  List<String> images = [
    'assets/images/imageslider3.jpeg',
    'assets/images/imageslider4.png',
    'assets/images/imageslider2.jpg',
    'assets/images/imageslider1.jpg',
    'assets/images/imageslider5.jpg',
  ];

  @override
  void initState() {
    super.initState();

    // Initialize the PageController
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8, // Adjust the fraction to introduce a gap
    );

    // Start auto-play
    startAutoPlay();
  }

  @override
  void dispose() {
    // Dispose of the PageController
    _pageController.dispose();

    super.dispose();
  }

  // Function to start auto-play
  void startAutoPlay() {
    // Set up a timer to change the page every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      // Animate to the next page
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
            child: Text(
          'Dashboard',
          style: TextStyle(
              fontFamily: 'Sora-VariableFont_wght.ttf', color: Colors.white),
        )),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('assets/images/Gomakerlogo.png'),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const BusinessDrawer(),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/white.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 200,
                    width: 500,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 8.0), // Add a margin for the gap
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 220, right: 10, left: 10),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Center(
                    child: Text(
                      'W e l c o m e    T o    B u s i n e s s    C a r d s',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 280, right: 10, left: 10),
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8A594).withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Categories:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontFamily: 'Sora-VariableFont_wght.ttf',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // List of ListTiles
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            6, // Change this to the number of list tiles you want
                        itemBuilder: (context, index) {
                          // Lists for title, subtitle, and leading image
                          List<String> cardsNames = [
                            'Show All Cards',
                            'Rate Us',
                            'Other Businesses',
                            'Customize Card',
                            'Scan Qr',
                            'Video Editing'
                          ];
                          List<String> work = [
                            'Busniness',
                            'Play store and App Store',
                            'Check out others',
                            'Edit Cards',
                            'Get cards details',
                            'Edit your own video'
                          ];
                          List<String> details = ['cards', '', '', '', '', ''];
                          List<String> leadingImages = [
                            'showall.png',
                            'rateuss.png',
                            'otherbusniss.png',
                            'customizee.png',
                            'scanmee.png',
                            'videoogoedit.png'
                          ];

                          return Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  // Perform different actions based on the index
                                  switch (index) {
                                    case 0:
                                      Fluttertoast.showToast(
                                        msg:
                                            "Your data has been fetched into cards",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: const ShowAllCards(),
                                        ),
                                        transitionDuration: const Duration(
                                            seconds:
                                                1), // Set the transition duration here
                                      ));
                                      break;
                                    case 1:
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return const RatingDialog();
                                        },
                                      );
                                      break;
                                    case 2:
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: const OtherBusniness(),
                                        ),
                                        transitionDuration: const Duration(
                                            seconds:
                                                1), // Set the transition duration here
                                      ));
                                      break;
                                    case 3:
                                      Fluttertoast.showToast(
                                        msg: "Cards Are Ready To Cutomize",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.grey,
                                        textColor: Colors.white,
                                        fontSize: 16.0,
                                      );
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: const ShowallCustomizeBc(),
                                        ),
                                        transitionDuration: const Duration(
                                            seconds:
                                                1), // Set the transition duration here
                                      ));
                                      break;
                                    case 4:
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: const QRScanner(),
                                        ),
                                        transitionDuration: const Duration(
                                            seconds:
                                                1), // Set the transition duration here
                                      ));
                                      break;
                                    case 5:
                                      Navigator.of(context)
                                          .push(PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            FadeTransition(
                                          opacity: animation,
                                          child: const VideoEditingScreen(),
                                        ),
                                        transitionDuration: const Duration(
                                            seconds:
                                                1), // Set the transition duration here
                                      ));
                                      break;
                                    default:
                                      break;
                                  }
                                },
                                child: ListTile(
                                  leading: SizedBox(
                                    width: 60,
                                    height: 60,
                                    child: Image.asset(
                                      'assets/images/${leadingImages[index]}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  title: Text(cardsNames[index]),
                                  subtitle:
                                      Text('${work[index]}  ${details[index]}'),
                                  trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.black),
                                ),
                              ),
                              if (index < 5)
                                const Divider(
                                  color: Colors.grey,
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
