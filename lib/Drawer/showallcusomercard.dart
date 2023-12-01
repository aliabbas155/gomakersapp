import 'package:flutter/material.dart';
import 'package:gomakersapp/CardsCustomer/customercard1.dart';
import 'package:gomakersapp/CardsCustomer/customercard10.dart';
import 'package:gomakersapp/CardsCustomer/customercard2.dart';
import 'package:gomakersapp/CardsCustomer/customercard3.dart';
import 'package:gomakersapp/CardsCustomer/customercard4.dart';
import 'package:gomakersapp/CardsCustomer/customercard5.dart';
import 'package:gomakersapp/CardsCustomer/customercard6.dart';
import 'package:gomakersapp/CardsCustomer/customercard7.dart';
import 'package:gomakersapp/CardsCustomer/customercard8.dart';
import 'package:gomakersapp/CardsCustomer/customercard9.dart';

class ShowAllCustomerCards extends StatefulWidget {
  const ShowAllCustomerCards({super.key});

  @override
  _ShowAllCustomerCardsState createState() => _ShowAllCustomerCardsState();
}

class _ShowAllCustomerCardsState extends State<ShowAllCustomerCards> {
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
                      child: const CustomerCard1(),
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
                      child: const CustomerCard2(),
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
                      child: const CustomerCard3(),
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
                      child: const CustomerCard4(),
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
                      child: const CustomerCard5(),
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
                      child: const CustomerCard6(),
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
                      child: const CustomerCard7(),
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
                      child: const CustomerCard8(),
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
                      child: const CustomerCard9(),
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
                      child: const CustomerCard10(),
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
