import 'package:flutter/material.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC1.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC10.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC2.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC3.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC4.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC5.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC6.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC7.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC8.dart';
import 'package:gomakersapp/CustomizeBusninessCards/Customize_BC9.dart';

class ShowallCustomizeBc extends StatefulWidget {
  const ShowallCustomizeBc({super.key});

  @override
  _ShowallCustomizeBcState createState() => _ShowallCustomizeBcState();
}

class _ShowallCustomizeBcState extends State<ShowallCustomizeBc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(children: [
        Image.asset(
          'assets/images/white.jpg', // Replace with the path to your background image asset
          fit: BoxFit.cover, // You can adjust the fit as needed
          width: double.infinity,
          height: double.infinity,
        ),
        GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            CardWidget(
              imageAsset: 'assets/images/logo.png',
              title: 'GoMaker Special',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard1(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),

            CardWidget(
              imageAsset: 'assets/images/docotorcardcover.png',
              title: 'Doctor Cards',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard2(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            // Add more CardWidgets with appropriate navigation
            CardWidget(
              imageAsset: 'assets/images/idcardcardcover.png',
              title: 'ID CARD',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard3(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/insurancecardcover.png',
              title: 'INSURANCE CARDS',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard4(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/schoolcardcover.png',
              title: 'SCHOOL CARDS',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard5(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/studentcardcover.png',
              title: 'STUDENT CARDS',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard6(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/unicardcover.png',
              title: 'UNIVERSITY CARDS',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard7(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/logo.png',
              title: 'CUSTOM CARDS',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard8(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/logo.png',
              title: 'CUSTOM CARDS',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard9(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/logo.png',
              title: 'CUSTOM CARDS',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const CustomizeBcard10(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
          ],
        ),
      ]),
    );
  }
}

class CardWidget extends StatefulWidget {
  final String imageAsset;
  final String title;
  final VoidCallback onTap;

  const CardWidget({
    super.key,
    required this.imageAsset,
    required this.title,
    required this.onTap,
  });

  @override
  _CardWidgetState createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset(
                widget.imageAsset,
                width: 150,
                height: 150,
              ),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 15,
                fontFamily: 'Sora-VariableFont_wght.ttf',
              ),
            ),
            IconButton(
              icon: isFavorite
                  ? const Icon(Icons.favorite, color: Colors.red)
                  : const Icon(Icons.favorite_border),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
