import 'package:flutter/material.dart';
import 'package:gomakersapp/BusinessCards/Business_cards1.dart';
import 'package:gomakersapp/BusinessCards/Business_cards10.dart';
import 'package:gomakersapp/BusinessCards/Business_cards2.dart';
import 'package:gomakersapp/BusinessCards/Business_cards3.dart';
import 'package:gomakersapp/BusinessCards/Business_cards4.dart';
import 'package:gomakersapp/BusinessCards/Business_cards5.dart';
import 'package:gomakersapp/BusinessCards/Business_cards6.dart';
import 'package:gomakersapp/BusinessCards/Business_cards7.dart';
import 'package:gomakersapp/BusinessCards/Business_cards8.dart';
import 'package:gomakersapp/BusinessCards/Business_cards9.dart';

class ShowAllCards extends StatefulWidget {
  const ShowAllCards({super.key});

  @override
  _ShowAllCardsState createState() => _ShowAllCardsState();
}

class _ShowAllCardsState extends State<ShowAllCards> {
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
          'assets/images/back.jpg', // Replace with the path to your background image asset
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
                    child: const BusinessCard1(),
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
                    child: const BusinessCard2(),
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
                    child: const BusinessCard3(),
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
                    child: const BusinessCard4(),
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
                    child: const BusinessCard5(),
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
                    child: const BusinessCard6(),
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
                    child: const BusinessCard7(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/logo.png',
              title: 'CUSTOME CARD',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const BusinessCard8(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/logo.png',
              title: 'CUSTOME CARD',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const BusinessCard9(),
                  ),
                  transitionDuration: const Duration(
                      seconds: 1), // Set the transition duration here
                ));
              },
            ),
            CardWidget(
              imageAsset: 'assets/images/logo.png',
              title: 'CUSTOME CARD',
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: const BusinessCard10(),
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
