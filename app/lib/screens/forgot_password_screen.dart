import 'package:ecommerce_shop/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = new TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
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
                color:
                    Theme.of(context).colorScheme.primaryFixed,
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
              onTap: () => null,
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
            Container(
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
            )
          ],
        ),
      ),
    );
  }
}
