import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:gomakersapp/LoginPage/login_page.dart';

Future<bool> logoutDailogbox(BuildContext context) async {
  Completer<bool> completer = Completer<bool>();

  AwesomeDialog(
    context: context,
    animType: AnimType.LEFTSLIDE,
    headerAnimationLoop: false,
    dialogType: DialogType.SUCCES,
    dismissOnTouchOutside: false,
    dismissOnBackKeyPress: false,
    closeIcon: Container(),
    showCloseIcon: true,
    title: 'Oops !!',
    desc: 'Are You Sure To Leave?',
    btnCancelOnPress: () {
      completer.complete(false); // User clicked 'NO'
    },
    btnCancelColor: Colors.green,
    btnOkText: 'YES',
    btnOkColor: Colors.red,
    buttonsTextStyle: const TextStyle(
        fontSize: 13, fontWeight: FontWeight.w400, color: Colors.white),
    btnCancelText: 'NO',
    btnOkOnPress: () {
      completer.complete(true); // User clicked 'YES'
      Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: const LoginScreen(),
        ),
        transitionDuration: const Duration(seconds: 1),
      ));
    },
    onDismissCallback: (type) {
      debugPrint('Dialog Dismiss from callback $type');
    },
  ).show();

  return completer.future;
}
