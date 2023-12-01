import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gomakersapp/LoginPage/Customer_Registration.dart';
import 'package:gomakersapp/LoginPage/Registration_page.dart';

void registerAsDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    // ignore: deprecated_member_use
    animType: AnimType.LEFTSLIDE,
    headerAnimationLoop: false,
    // ignore: deprecated_member_use
    dialogType: DialogType.SUCCES,
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    closeIcon: Container(),
    showCloseIcon: true,
    title: 'Register Your Profile',
    desc: 'How do you want to register?',
    btnCancelOnPress: () {
      // Handle the logic for registering as a business
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegistrationPage()));
    },
    btnCancelColor: const Color.fromRGBO(255, 46, 13, 1),
    btnOkText: 'As Customer',
    buttonsTextStyle: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white),
    btnCancelText: 'As Business',
    btnOkOnPress: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CustomerRegistrationScreen()));
    },
    onDismissCallback: (type) {
      debugPrint('Dialog Dismiss from callback $type');
    },
  ).show();
}
