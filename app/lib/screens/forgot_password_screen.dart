import 'dart:async';

import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/widgets/custom_text_field.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  late bool _isWatingResendEmail = false;
  Timer? _timer;
  int _remainingTime = 15; // Số giây đếm ngược

  void _activateFor15Seconds() {
    setState(() {
      _isWatingResendEmail = true;
      _remainingTime = 15; // Reset lại thời gian
    });

    // Bắt đầu bộ đếm thời gian
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
      });

      // Khi thời gian hết, hủy timer và đặt lại _isActive
      if (_remainingTime == 0) {
        _timer?.cancel();
        setState(() {
          _isWatingResendEmail = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IntrinsicWidth(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Theme.of(context).colorScheme.outline)),
                  child: Center(
                    child: Icon(
                      Icons.fingerprint,
                      size: 42,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Forgot Password?",
              style: GoogleFonts.manrope(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primaryFixed),
            ),
            SizedBox(height: 10),
            Text(
              "We will send new password to your email.",
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primaryFixed,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: _emailController,
              context: context,
              hintText: "Email",
              prefixIcon: Icon(Icons.email),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                String _email = _emailController.text.trim();
                if (_email.isEmpty || _email.length == 0) {
                  NotifyToast(
                    context: context,
                    message: "Please type your email",
                  ).ShowToast();
                  return;
                }

                if (_isWatingResendEmail) {
                  WarningToast(
                    context: context,
                    message: "Please try again after $_remainingTime seconds",
                  ).ShowToast();
                  return;
                } else {
                  _activateFor15Seconds();
                  LoadingDialog(context);
                  try {
                    var check = await RequestNewPassword(_email);
                    if (check) {
                      SuccessToast(
                        context: context,
                        message: "Please check your email to get new password",
                        duration: Duration(seconds: 3),
                      ).ShowToast();
                    } else {
                      WarningToast(
                        context: context,
                        message: "Error when send email.",
                      ).ShowToast();
                    }
                  } catch (e) {
                    WarningToast(
                      context: context,
                      message: e.toString().replaceAll("Exception: ", ""),
                    ).ShowToast();
                  } finally {
                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Center(
                  child: Text(
                    "Get new password",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignInScreen(email: _emailController.text,)),
                    (dynamic Route) => false);
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.arrow_back),
                    SizedBox(width: 10),
                    Text(
                      "Back to login",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
