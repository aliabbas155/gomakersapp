import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gomakersapp/AlertDialog/logoutdialog.dart';
import 'package:gomakersapp/DeleteProfile/deleteprofile.dart';
import 'package:gomakersapp/Drawer/myprofile.dart';
import 'package:gomakersapp/UpdateProfile/updateprofile.dart';
import 'package:gomakersapp/openprofileimage/profileimage_viewer.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';

class BusinessDrawer extends StatefulWidget {
  const BusinessDrawer({super.key});

  @override
  _BusinessDrawerState createState() => _BusinessDrawerState();
}

class _BusinessDrawerState extends State<BusinessDrawer> {
  bool isOpen = false;
  String? profileImageUrl;
  late DocumentSnapshot? data;

  @override
  void initState() {
    super.initState();
    fetchDataFromFirebase().then((document) {
      setState(() {
        data = document;
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

  @override
  Widget build(BuildContext context) {
    void _onShare(BuildContext context) async {
      final box = context.findRenderObject() as RenderBox?;

      String linkToShare = "https://www.numl.edu.pk/";
      String text = "Check out this link: $linkToShare";
      String subject = "Sharing with Friends";

      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // Show a dialog with options
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Profile Image"),
                    contentPadding: const EdgeInsets.all(0),
                    content: SizedBox(
                      height: 200, // Set the desired height
                      child: Column(
                        children: [
                          Lottie.asset(
                            'assets/images/happy.json', // Adjust the path accordingly
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 5),
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                "Do you want to view or update your profile image?"),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ImageViewer(imageUrl: profileImageUrl!),
                            ),
                          );
                        },
                        child: const Text("View"),
                      ),
                      TextButton(
                        onPressed: () {
                          _updateProfileImage();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Updating profile image..."),
                            ),
                          );
                        },
                        child: const Text("Update"),
                      ),
                    ],
                  );
                },
              );
            },
            child: SizedBox(
              height: 300,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Container(
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
                        : const AssetImage('assets/images/blackimage.jpg')
                            as ImageProvider<Object>,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_box),
            title: const Text(
              'My Profile',
              style: TextStyle(
                  fontFamily: 'Sora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FadeTransition(
                  opacity: animation,
                  child: const Profile(),
                ),
                transitionDuration: const Duration(seconds: 1),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text(
              'Edit My Profile',
              style: TextStyle(
                  fontFamily: 'Sora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FadeTransition(
                  opacity: animation,
                  child: const UpdateProfile(),
                ),
                transitionDuration: const Duration(seconds: 1),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text(
              'Delete Card',
              style: TextStyle(
                  fontFamily: 'Sora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FadeTransition(
                  opacity: animation,
                  child: const DeleteProfileData(),
                ),
                transitionDuration: const Duration(seconds: 1),
              ));
            },
          ),
          const Divider(
            color: Colors.black,
          ),
          Builder(
            builder: (BuildContext context) {
              return ListTile(
                leading: const Icon(Icons.share),
                title: const Text(
                  'Share With Friends',
                  style: TextStyle(
                      fontFamily: 'Sora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  _onShare(context);
                },
              );
            },
          ),
          const Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text(
              'Log Out',
              style: TextStyle(
                  fontFamily: 'Sora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              logoutDailogbox(context);
            },
          ),
        ],
      ),
    );
  }

  void _updateProfileImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      // Upload the image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images/${DateTime.now().toString()}');
      UploadTask uploadTask = storageReference.putFile(imageFile);

      await uploadTask.whenComplete(() async {
        // Get the download URL for the uploaded image
        String imageUrl = await storageReference.getDownloadURL();

        // Update the profile image URL in Firestore
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await FirebaseFirestore.instance
              .collection('gomarkerdata')
              .doc(user.uid)
              .update({'imageUrl': imageUrl});

          // Update the local state
          setState(() {
            profileImageUrl = imageUrl;
          });

          // Display a success message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Profile image updated successfully."),
            ),
          );
        }
      });
    }
  }
}
