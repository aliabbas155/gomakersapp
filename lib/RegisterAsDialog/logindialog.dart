import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomakersapp/AlertDialog/aleartdialogbox.dart';
import 'package:gomakersapp/HomeScreen/Customer_Home_Screen.dart';
import 'package:gomakersapp/HomeScreen/Homescreen.dart';
import 'package:gomakersapp/config/constant.dart';

Future<void> loginAsDialog(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController) async {
  AwesomeDialog(
    context: context,
    animType: AnimType.LEFTSLIDE,
    headerAnimationLoop: false,
    dialogType: DialogType.SUCCES,
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    closeIcon: Container(),
    showCloseIcon: true,
    title: 'Login Your Profile',
    desc: 'How do you want to login?',
    btnCancelOnPress: () {
      // Handle "As Business" button press
      checkAndNavigate(context, emailController, passwordController,
          asBusiness: true);
    },
    btnCancelColor: Colors.red,
    btnOkText: 'As Customer',
    buttonsTextStyle:
        const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
    btnCancelText: 'As Business',
    btnOkOnPress: () {
      // Handle "As Customer" button press
      checkAndNavigate(context, emailController, passwordController,
          asBusiness: false);
    },
    onDismissCallback: (type) {
      debugPrint('Dialog Dismiss from callback $type');
    },
  ).show();
}

Future<void> deleteUserAccount() async {
  try {
    await FirebaseAuth.instance.currentUser!.delete();
  } on FirebaseAuthException catch (e) {
    logger.e(e);
  } catch (e) {
    logger.e(e);

    // Handle general exception
  }
}

Future<void> checkAndNavigate(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController,
    {required bool asBusiness}) async {
  try {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    if (userCredential.user != null) {
      final userId = userCredential.user!.uid;
      final collectionName = asBusiness ? 'gomarkerdata' : 'ascustomer';

      // Check if user data exists in the selected collection
      final snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(userId)
          .get();
      logger.i(snapshot.data());

      //** Checking Data for empty */ true
      if (snapshot.exists) {
        // User data found, navigate to the appropriate screen
        if (asBusiness) {
          // Show a toast message for Business
          Fluttertoast.showToast(
            msg: 'Welcome, You Are Login As Business',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.green, // Change the color as desired
            textColor: Colors.white,
          );

          // Navigate to the business screen (e.g., HomeScreen)
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          // Show a toast message for Customer
          Fluttertoast.showToast(
            msg: 'Welcome, You Are Login As Customer',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.blue, // Change the color as desired
            textColor: Colors.white,
          );

          // Navigate to the customer screen (e.g., QRScannerWidget)
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const CustomerHomeScreen()));
        }
      } else {
        logger.e('Document not found.');
        // User data not found, show an error dialog
        var name = asBusiness ? 'Bussiness' : 'Customer';
        try {
          var other = !asBusiness ? 'Bussiness' : 'Customer';

          final userId = userCredential.user!.uid;

          final collectionName = !asBusiness ? 'gomarkerdata' : 'ascustomer';
          // Check if user data exists in the selected collection
          final snapshot = await FirebaseFirestore.instance
              .collection(collectionName)
              .doc(userId)
              .get();
          if (snapshot.exists) {
            errorDialog(
                context: context,
                msg:
                    'Your account type is $other.\nPlease select the correct type to login.',
                title: 'Info');
          } else {
            await deleteUserAccount();
            errorDialog(
                context: context,
                msg: 'You are not a user of this app',
                title: 'Info');
          }
        } catch (e) {
          logger.e(e);
          errorDialog(
              context: context, msg: 'Something went wrong', title: "Info");
        }
        // errorDialog(
        //     context: context, msg: 'No record found in $name', title: 'Info');
      }
    }
    //** Checking USer for empty */ false
    else {
      logger.e('User Not  is Empty');
      // Handle the case when the user is not authenticated or an error occurs during authentication
      errorDialog(context: context, title: 'No Account');
    }
  } catch (e) {
    // Handle any exceptions that may occur during the process
    logger.e('Error: $e');
    errorDialog(
      context: context,
    );
  }
}
