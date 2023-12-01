import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomerProfile extends StatefulWidget {
  const CustomerProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CustomerProfileState createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();

  late DocumentSnapshot? data;
  bool isEditingEnabled = false;
  String? profileImageUrl;
  bool isAvatarTapped = false;
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/colorback.jpg'), // Replace with your image path
            fit: BoxFit
                .cover, // You can adjust the fit to cover or contain as needed
          ),
        ),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * .5,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(
                              MediaQuery.of(context).size.width * 0.5, 100.0),
                          bottomRight: Radius.elliptical(
                              MediaQuery.of(context).size.width * 0.5, 100.0),
                        ),
                        image: const DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: AssetImage(
                            'assets/images/slider1.png',
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xffD8D8D8),
                          child: Icon(
                            Icons.chat,
                            size: 30,
                            color: Color(0xff6E6E6E),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Toggle the isAvatarTapped state when the user taps on the avatar
                            setState(() {
                              isAvatarTapped = !isAvatarTapped;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(
                                milliseconds:
                                    5000), // Add an animation duration
                            curve: Curves
                                .easeOut, // Add a curve for smooth animation
                            width: isAvatarTapped
                                ? 200
                                : 100, // Increase the width when tapped
                            height: isAvatarTapped
                                ? 200
                                : 100, // Increase the height when tapped
                            child: CircleAvatar(
                              radius: isAvatarTapped
                                  ? 60
                                  : 50, // Increase the radius when tapped
                              backgroundImage: profileImageUrl != null
                                  ? NetworkImage(profileImageUrl!)
                                  : const AssetImage('assets/images/uni.png')
                                      as ImageProvider<Object>,
                            ),
                          ),
                        ),
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xffD8D8D8),
                          child: Icon(
                            Icons.call,
                            size: 30,
                            color: Color(0xff6E6E6E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black, width: 2.0), // Add black border
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: Add rounded corners
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.person, // Your desired icon
                          color: Colors.red, // Icon color
                        ),
                        const SizedBox(
                            width:
                                8.0), // Optional spacing between the icon and the text field
                        Expanded(
                          child: TextField(
                            controller: nameController,
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            enabled: isEditingEnabled,
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Optional: Add some padding
                              border: InputBorder
                                  .none, // Remove the default TextField border
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black, width: 2.0), // Add black border
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: Add rounded corners
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.email,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: emailController,
                            enabled: isEditingEnabled,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Optional: Add some padding
                              border: InputBorder
                                  .none, // Remove the default TextField border
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.black, width: 2.0), // Add black border
                      borderRadius: BorderRadius.circular(
                          8.0), // Optional: Add rounded corners
                    ),
                    child: Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_city_rounded,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: TextField(
                            controller: cityController,
                            enabled: isEditingEnabled,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal:
                                      10.0), // Optional: Add some padding
                              border: InputBorder
                                  .none, // Remove the default TextField border
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
