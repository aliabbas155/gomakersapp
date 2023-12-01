import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class DeleteCustomerProfile extends StatefulWidget {
  const DeleteCustomerProfile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DeleteCustomerProfileState createState() => _DeleteCustomerProfileState();
}

class _DeleteCustomerProfileState extends State<DeleteCustomerProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final cityController = TextEditingController();

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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    showDeleteConfirmationDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
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
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                  label: const Text(
                    'Delete Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 180,
            child: Column(
              children: [
                Lottie.asset(
                  'assets/images/delete.json', // Replace with your Lottie animation file
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                const Text('Are you sure you want to delete your data?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Call the function to delete data
                deleteUserData();
                // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void deleteUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the user's document in the 'ascustomer' collection
      final userDocRef =
          FirebaseFirestore.instance.collection('ascustomer').doc(user.uid);

      try {
        // Delete the document
        await userDocRef.delete();

        // Log out the user
        await FirebaseAuth.instance.signOut();

        // Close the app
        SystemNavigator.pop();
      } catch (e) {
        print('Error deleting user data: $e');
        // Handle any errors that may occur during deletion
      }
    }
  }
}
