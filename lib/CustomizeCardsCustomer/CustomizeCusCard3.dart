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

class CustomizeCusCard3 extends StatefulWidget {
  const CustomizeCusCard3({super.key});

  @override
  _CustomizeCusCard3State createState() => _CustomizeCusCard3State();
}

class _CustomizeCusCard3State extends State<CustomizeCusCard3> {
  late DocumentSnapshot? data;
  String? profileImageUrl;
  late List<Color> gradientColors;
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
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    gradientColors = generateRandomGradient();
    fetchDataFromFirebase().then((document) {
      setState(() {
        data = document;
        // Populate the controllers with the initial data
        nameController.text = data?['name'] ?? 'Your Name';
        emailController.text = data?['email'] ?? 'email@example.com';
        cityController.text = data?['selectedCity'] ?? 'City';

        profileImageUrl = data?['imageUrl'];
      });
    });
  }

  Future<DocumentSnapshot?> fetchDataFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final document = await FirebaseFirestore.instance
          .collection('ascustomer')
          .doc(user.uid)
          .get();

      if (document.exists) {
        final imageUrl = document.data()?['imageUrl'];
        if (imageUrl != null) {
          setState(() {
            profileImageUrl = imageUrl;
          });
        }
        return document;
      }
    }

    return null;
  }

  List<Color> generateRandomGradient() {
    final Random random = Random();
    final Color color1 = Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1.0);
    final Color color2 = Color.fromRGBO(
        random.nextInt(256), random.nextInt(256), random.nextInt(256), 1.0);
    return [color1, color2];
  }

  Widget generateQRCode() {
    final qrData = "${nameController.text}\n"
        "${emailController.text}\n"
        "${cityController.text}";

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

  void changeCardColor() {
    setState(() {
      gradientColors = generateRandomGradient();
    });
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

  void shareCard() {
    final qrData = "${nameController.text}\n"
        "${emailController.text}\n"
        "${cityController.text}";

    Share.share(qrData); // Use the Share package to share the QR code data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(''),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/idcard5.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            RepaintBoundary(
              key: _globalKey,
              child: Card(
                elevation: 5.0,
                margin: const EdgeInsets.all(16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              SizedBox(
                                child: generateQRCode(),
                              ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.person,
                                    color: currentFontColor,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'Name:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: currentFontFamily,
                                      color: currentFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: nameController,
                                  style: TextStyle(
                                    fontFamily: currentFontFamily,
                                    fontSize: 16.0,
                                    color: currentFontColor,
                                    // Add more properties as needed
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter name',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.email,
                                    color: currentFontColor,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'Email:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: currentFontFamily,
                                      color: currentFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: emailController,
                                  style: TextStyle(
                                    fontFamily: currentFontFamily,
                                    fontSize: 16.0,
                                    color: currentFontColor,
                                    // Add more properties as needed
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter email',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_city_rounded,
                                    color: currentFontColor,
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    'City:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: currentFontFamily,
                                      color: currentFontColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: cityController,
                                  style: TextStyle(
                                    fontFamily: currentFontFamily,
                                    fontSize: 16.0,
                                    color: currentFontColor,
                                    // Add more properties as needed
                                  ),
                                  decoration: const InputDecoration(
                                    hintText: 'Enter city',
                                    border: InputBorder.none,
                                  ),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: changeCardColor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(
                        15, 175, 150, 1), // Set the button color to red
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.change_circle_sharp,
                          color: Colors.white), // Add a star icon
                      SizedBox(
                          width:
                              8), // Add some spacing between the icon and text
                      Text('Change Card Color',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  onPressed: () {
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(
                          0, 100, 0, 0), // Adjust the position as needed
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
                          value: 'DMSans-Italic-VariableFont_opsz,wght.ttf',
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
                        color: Color.fromRGBO(15, 175, 150, 1),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Change Font Style',
                        style: TextStyle(
                            color: Color.fromRGBO(15, 175, 150, 1),
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(15, 175, 150, 1),
                    elevation: 0,
                  ),
                  onPressed: pickFontColor,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.color_lens_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Change Font Color ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  onPressed: shareCard,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.share,
                        color: Colors.green,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Share Card ',
                        style: TextStyle(color: Colors.green, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                height: 50,
                width: 300,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(15, 175, 150, 1),
                    elevation: 0,
                  ),
                  onPressed: _captureCardImage,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.save_alt_outlined,
                        color: Colors.white,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Save To Gallery',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
