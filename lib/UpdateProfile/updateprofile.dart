import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final nameController = TextEditingController();
  final businessNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();
  late DocumentSnapshot? data;
  bool isEditingEnabled = false;
  String? profileImageUrl;
  bool isAvatarTapped = false;
  bool isLoading = false;
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

  Future<void> updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance
          .collection('gomarkerdata')
          .doc(user.uid)
          .update({
        'name': nameController.text,
        'businessName': businessNameController.text,
        'phoneNumber': phoneNumberController.text,
        'email': emailController.text,
        'selectedCity': cityController.text,
        'businessAddress': addressController.text,
        'description': descriptionController.text,
        // Add other fields as needed
      });
      setState(() {
        isLoading = true;
      });

      try {
        // Your update logic here

        // Simulating a delay (you can remove this in your actual code)
        await Future.delayed(const Duration(seconds: 2));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Lottie.asset(
              'assets/images/Animation - 1700803792476.json', // Replace with your Lottie animation file
              width: 200,
              height: 200,
              repeat: true,
            ),
            content: const Text('Profile updated successfully'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/updatewhite.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.15),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                              'assets/images/logo.png',
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
                            backgroundColor: Colors.orange,
                            child: Icon(
                              Icons.chat,
                              size: 30,
                              color: Colors.white,
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
                            backgroundColor: Colors.orange,
                            child: Icon(
                              Icons.call,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.orange,
                            width: 2.0), // Add black border
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.person, // Your desired icon
                            color: Colors.orange, // Icon color
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
                              // enabled: isEditingEnabled,
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
                            color: Colors.orange,
                            width: 2.0), // Add black border
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons
                                .workspace_premium_rounded, // Your desired icon
                            color: Colors.orange, // Icon color
                          ),
                          const SizedBox(
                              width:
                                  8.0), // Optional spacing between the icon and the text field
                          Expanded(
                            child: TextField(
                              controller: businessNameController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                              decoration: const InputDecoration(
                                hintText: "Enter Business Name",
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
                            color: Colors.orange,
                            width: 2.0), // Add black border
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.phone,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: phoneNumberController,
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
                            color: Colors.orange,
                            width: 2.0), // Add black border
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.email,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: emailController,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
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
                            color: Colors.orange,
                            width: 2.0), // Add black border
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_city_rounded,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: cityController,
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
                            color: Colors.orange,
                            width: 2.0), // Add black border
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.location_on,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: TextField(
                              controller: addressController,
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
                            color: Colors.orange,
                            width: 2.0), // Add black border
                        borderRadius: BorderRadius.circular(
                            8.0), // Optional: Add rounded corners
                      ),
                      child: Row(
                        children: <Widget>[
                          const Icon(
                            Icons.border_vertical_outlined,
                            color: Colors.orange,
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: SizedBox(
                              // Increase the height of the text field
                              child: TextField(
                                controller: descriptionController,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                                decoration: const InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      updateProfile();
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                    ),
                    icon: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.update_outlined,
                            color: Colors.white,
                          ),
                    label: const Text(
                      'Update Data',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
