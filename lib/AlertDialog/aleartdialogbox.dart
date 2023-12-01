import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gomakersapp/LoginPage/login_page.dart';


void errorDialog({required BuildContext context, String? msg, String? title}) {
  AwesomeDialog(
    context: context,
    // ignore: deprecated_member_use
    dialogType: DialogType.ERROR,
    // ignore: deprecated_member_use
    animType: AnimType.SCALE,
    headerAnimationLoop: true,
    title: title ?? 'Invalid Credentials',
    desc: msg ?? 'Please try again with valid email and password',
    btnOkOnPress: () {
      // Navigate to the login screen when "Ok" is tapped
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    },
    btnOkIcon: Icons.cancel,
    btnOkColor: Colors.red,
  ).show();
}
