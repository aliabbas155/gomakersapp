import 'package:flutter/material.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard1.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard10.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard2.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard3.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard4.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard5.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard6.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard7.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard8.dart';
import 'package:gomakersapp/CustomizeCardsCustomer/CustomizeCusCard9.dart';

class ShowallCustomizeCCard extends StatefulWidget {
  const ShowallCustomizeCCard({super.key});

  @override
  _ShowallCustomizeCCardState createState() => _ShowallCustomizeCCardState();
}

class _ShowallCustomizeCCardState extends State<ShowallCustomizeCCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/classy.jpg', // Replace with the path to your background image asset
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
                      child: const CustomizeCusCard1(),
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
                      child: const CustomizeCusCard2(),
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
                      child: const CustomizeCusCard3(),
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
                      child: const CustomizeCusCard4(),
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
                      child: const CustomizeCusCard5(),
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
                      child: const CustomizeCusCard6(),
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
                      child: const CustomizeCusCard7(),
                    ),
                    transitionDuration: const Duration(
                        seconds: 1), // Set the transition duration here
                  ));
                },
              ),
              CardWidget(
                imageAsset: 'assets/images/logo.png',
                title: 'CUSTOM CARD',
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FadeTransition(
                      opacity: animation,
                      child: const CustomizeCusCard8(),
                    ),
                    transitionDuration: const Duration(
                        seconds: 1), // Set the transition duration here
                  ));
                },
              ),
              CardWidget(
                imageAsset: 'assets/images/logo.png',
                title: 'CUSTOM CARD',
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FadeTransition(
                      opacity: animation,
                      child: const CustomizeCusCard9(),
                    ),
                    transitionDuration: const Duration(
                        seconds: 1), // Set the transition duration here
                  ));
                },
              ),
              CardWidget(
                imageAsset: 'assets/images/logo.png',
                title: 'CUSTOM CARD',
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        FadeTransition(
                      opacity: animation,
                      child: const CustomizeCusCard10(),
                    ),
                    transitionDuration: const Duration(
                        seconds: 1), // Set the transition duration here
                  ));
                },
              ),
            ],
          ),
        ],
      ),
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
      onTap: () {
        // Trigger the onTap callback
        widget.onTap();
      },
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(
            color: Colors.orange,
            width: 4.0,
          ),
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
              style: const TextStyle(fontSize: 17),
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
