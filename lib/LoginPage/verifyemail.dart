import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gomakersapp/AlertDialog/logoutdialog.dart';
import 'package:gomakersapp/HomeScreen/Customer_Home_Screen.dart';


class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    if (!mounted) return;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 10));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    timer;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const CustomerHomeScreen()
      : WillPopScope(
          onWillPop: () async {
            return await logoutDailogbox(context);
          },
          child: Scaffold(
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Center(
                    child: Icon(
                      Icons.check_circle_rounded,
                      color: Colors.red,
                      size: 200,
                    ),
                  ),
                  const Center(
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                      ),
                      child: Text('Verification Send to Email'),
                    ),
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                        child: Text(
                            'If you cannot verify email then go back to login screeen and login when verified'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                      onPressed: () {
                        canResendEmail ? sendVerificationEmail() : null;
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: const Color(0xFF264077),
                        // ignore: prefer_const_constructors
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Resend Email',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.red),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 80),
                    child: ElevatedButton(
                      onPressed: () {
                        logoutDailogbox(context);
                        dispose();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5.0,
                        backgroundColor: const Color(0xFF264077),
                        // ignore: prefer_const_constructors
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 20,
                            color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
}
