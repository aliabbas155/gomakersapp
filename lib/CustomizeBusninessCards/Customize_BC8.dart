import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class CustomizeBcard8 extends StatefulWidget {
  const CustomizeBcard8({
    super.key,
  });

  @override
  _CustomizeBcard8State createState() => _CustomizeBcard8State();
}

class _CustomizeBcard8State extends State<CustomizeBcard8> {
  late DocumentSnapshot? data;
  bool isEditingEnabled = false;
  String? profileImageUrl;
  String currentFontFamily = 'DefaultFont';
  Color currentFontColor = Colors.white;
  final GlobalKey _globalKey = GlobalKey();
  Uint8List? capturedImageBytes;
  Future<void> _captureCardImage() async {
    try {
      // Add a delay to allow Flutter to complete the rendering
      await Future.delayed(const Duration(milliseconds: 500));

      RenderRepaintBoundary boundary = _globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      // Capture only the card image
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();

        setState(() {
          capturedImageBytes = pngBytes;
        });

        print('Card Image Captured: ${pngBytes.lengthInBytes} bytes');

        // Save the card image to the gallery
        final tempDir = await getTemporaryDirectory();
        final file =
            await File('${tempDir.path}/card_image.png').writeAsBytes(pngBytes);

        final result = await GallerySaver.saveImage(file.path);
        print('Card Image saved to gallery: $result');

        // Show toast message
        Fluttertoast.showToast(
          msg: 'Card image saved to gallery',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        print('Error: ByteData is null');
      }
    } catch (e) {
      print('Error capturing and saving card image: $e');
    }
  } // Set an initial font family

  List<String> backgroundImageList = [
    'assets/images/customimage3.jpg',
    'assets/images/idcard5.png',
    'assets/images/white.jpg',
    'assets/images/university5.jpeg',
  ];

  int currentBackgroundImageIndex = 0;

  final nameController = TextEditingController();
  final businessNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  int maxlines = 8;
  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase().then((document) {
      setState(() {
        data = document;
        // Populate the controllers with the initial data
        nameController.text = data?['name'] ?? 'Your Name';
        businessNameController.text = data?['businessName'] ?? 'Business Name';
        phoneNumberController.text = data?['phoneNumber'] ?? 'Phone Number';
        emailController.text = data?['email'] ?? 'email@example.com';
        cityController.text = data?['selectedCity'] ?? 'City';
        addressController.text = data?['businessAddress'] ?? 'Business Address';
        descriptionController.text = data?['description'] ?? 'Description';
        profileImageUrl = data?['imageUrl'];
      });
    });
  }

  Future<DocumentSnapshot?> fetchDataFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final document = await FirebaseFirestore.instance
          .collection('gomarkerdata')
          .doc(user.uid)
          .get();

      if (document.exists) {
        final imageUrl = document.data()?['imageUrl']; // Fetch "imageUrl" field
        if (imageUrl != null) {
          setState(() {
            profileImageUrl = imageUrl; // Set the profileImageUrl
          });
        }
        return document;
      }
    }

    return null;
  }

  Widget generateQRCode() {
    final qrData = "${nameController.text}\n"
        "${businessNameController.text}\n"
        "${phoneNumberController.text}\n"
        "${emailController.text}\n"
        "${cityController.text}\n"
        "${addressController.text}\n"
        "${descriptionController.text}";

    return Container(
      decoration: BoxDecoration(
        color: Colors.black, // Background color of the QR code
        border: Border.all(color: Colors.black),
      ),
      child: QrImageView(
        data: qrData,
        version: QrVersions.auto,
        size: 80, // Adjust the size as needed
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        gapless: true, // Adjust the size as needed
      ),
    );
  }

  void shareCard() {
    final qrData = "${nameController.text}\n"
        "${businessNameController.text}\n"
        "${phoneNumberController.text}\n"
        "${emailController.text}\n"
        "${cityController.text}\n"
        "${addressController.text}\n"
        "${descriptionController.text}";

    Share.share(qrData); // Use the Share package to share the QR code data
  }

  void changeFontFamily(String fontFamily) {
    setState(() {
      currentFontFamily = fontFamily;
    });
  }

  void pickFontColor() {
    final randomColor = Color((Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0); // Generate a random color
    setState(() {
      currentFontColor = randomColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(fontFamily: currentFontFamily),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(''),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/back.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: <Widget>[
                  RepaintBoundary(
                    key: _globalKey,
                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.all(16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              backgroundImageList[currentBackgroundImageIndex],
                            ),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.10),
                              BlendMode.dstATop,
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextField(
                                  decoration: InputDecoration(
                                    hintText:
                                        'Enter your text here', // You can set your own hint text
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: currentFontFamily,
                                      color: currentFontColor,
                                      letterSpacing:
                                          2.0, // Adjust the letter spacing as needed
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: currentFontFamily,
                                    color: currentFontColor,
                                    letterSpacing:
                                        2.0, // Adjust the letter spacing as needed
                                  ),
                                ),

                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      child: generateQRCode(),
                                    ),
                                    const SizedBox(width: 120.0),
                                    Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.black, // border color
                                          width: 2.0, // border width
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage: profileImageUrl != null
                                            ? NetworkImage(profileImageUrl!)
                                            : const AssetImage(
                                                    'assets/images/uni.png')
                                                as ImageProvider<Object>,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                // Use TextField widgets with controllers for inline editing
                                TextField(
                                  controller: nameController,
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: currentFontFamily,
                                    color: currentFontColor,
                                  ),
                                  enabled: isEditingEnabled,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons
                                          .person, // You can choose any icon you prefer
                                      color: currentFontColor,
                                    ),
                                  ),
                                ),

                                TextField(
                                  controller: businessNameController,
                                  style: TextStyle(
                                    color: currentFontColor,
                                    fontFamily: currentFontFamily,
                                    fontSize: 16.0,
                                  ),
                                  enabled: isEditingEnabled,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons
                                          .business, // You can choose any relevant business-related icon
                                      color: currentFontColor,
                                    ),
                                    hintText: "Enter Business Name",
                                  ),
                                ),

                                const SizedBox(height: 16.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.phone,
                                      color: currentFontColor,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: TextField(
                                        controller: phoneNumberController,
                                        enabled: isEditingEnabled,
                                        style: TextStyle(
                                          color:
                                              currentFontColor, // Set the text color to white
                                          fontSize: 16.0,
                                          fontFamily: currentFontFamily,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder
                                              .none, // Remove the border
                                        ), // Enable text field based on flag
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.email,
                                      color: currentFontColor,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: TextField(
                                        controller: emailController,
                                        enabled: isEditingEnabled,
                                        style: TextStyle(
                                          color:
                                              currentFontColor, // Set the text color to white
                                          fontSize: 16.0,
                                          fontFamily: currentFontFamily,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder
                                              .none, // Remove the border
                                        ), // Enable text field based on flag
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_city_rounded,
                                      color: currentFontColor,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: TextField(
                                        controller: cityController,
                                        enabled: isEditingEnabled,
                                        style: TextStyle(
                                          color:
                                              currentFontColor, // Set the text color to white
                                          fontSize: 16.0,
                                          fontFamily: currentFontFamily,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder
                                              .none, // Remove the border
                                        ), // Enable text field based on flag
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      color: currentFontColor,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: TextField(
                                        controller: addressController,
                                        enabled: isEditingEnabled,
                                        style: TextStyle(
                                          color:
                                              currentFontColor, // Set the text color to white
                                          fontSize: 16.0,
                                          fontFamily: currentFontFamily,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder
                                              .none, // Remove the border
                                        ), // Enable text field based on flag
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16.0),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.wallet_rounded,
                                      color: currentFontColor,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: TextField(
                                        controller: descriptionController,
                                        enabled: isEditingEnabled,
                                        maxLines: maxlines,
                                        style: TextStyle(
                                          color:
                                              currentFontColor, // Set the text color to white
                                          fontSize: 16.0,
                                          fontFamily: currentFontFamily,
                                        ),
                                        decoration: const InputDecoration(
                                          border: InputBorder
                                              .none, // Remove the border
                                        ), // Enable text field based on flag
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceEvenly, // Adjust alignment as needed
                    children: [
                      SizedBox(
                        height: 50,
                        width: 170,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              // Increment the background image index, and cycle back to the first image
                              currentBackgroundImageIndex =
                                  (currentBackgroundImageIndex + 1) %
                                      backgroundImageList.length;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(15, 175, 150, 1),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.change_circle_outlined,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Change image',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(15, 175, 150, 1),
                          ),
                          onPressed: () {
                            showMenu(
                              context: context,
                              position: const RelativeRect.fromLTRB(0, 100, 0,
                                  0), // Adjust the position as needed
                              items: <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'DefaultFont',
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text('Default Font'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Agbalumo-Regular.ttf',
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text('Agbalumo'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Kanit-LightItalic.ttf',
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text('Kanit'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value:
                                      'DMSans-Italic-VariableFont_opsz,wght.ttf',
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text('DMSans'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'Exo2-Italic-VariableFont_wght.ttf',
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text('Exo2'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                  value: 'PTSerif-Bold.ttf',
                                  child: Row(
                                    children: [
                                      Icon(Icons.arrow_right),
                                      Text('PTSerif'),
                                    ],
                                  ),
                                ),
                                // Add more font options as needed
                              ],
                            ).then((value) {
                              if (value != null) {
                                changeFontFamily(value);
                              }
                            });
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.font_download,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'Font Style',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(15, 175, 150, 1),
                            elevation: 0,
                          ),
                          onPressed: shareCard,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.white,
                              ),
                              // SizedBox(width: 35),
                              Text(
                                'Share Card ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //     width: 10), // Add some spacing between the buttons
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(15, 175, 150, 1),
                            elevation: 0,
                          ),
                          onPressed: pickFontColor,
                          child: const Row(
                            children: [
                              Icon(
                                Icons.color_lens_outlined,
                                color: Colors.white,
                              ),
                              // SizedBox(width: 35),
                              Text(
                                'Font Color ',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(15, 175, 150, 1),
                        elevation: 0,
                      ),
                      onPressed: _captureCardImage,
                      child: const Row(
                        children: [
                          Icon(
                            Icons.save_alt_outlined,
                            color: Colors.white,
                          ),
                          // SizedBox(width: 35),
                          Text(
                            'Save To Gallery',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
