import 'package:ecommerce_shop/screens/send_email_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/screens/signup_screen.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Shopoes",
          style: GoogleFonts.manrope(
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => SignUpScreen()),
                  (dynamic Route) => false);
            },
            child: Text(
              "Create an account",
              style: GoogleFonts.manrope(
                fontSize: 16,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IntrinsicWidth(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                    border: Border.all(
                      color: Theme.of(context)
                          .colorScheme
                          .outline
                          .withOpacity(0.4),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Icon(
                    Icons.fingerprint,
                    color: Theme.of(context).colorScheme.primaryFixed,
                    size: 50,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Forgot Password?",
              style: GoogleFonts.manrope(
                  fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text("No worries, we\'ll send  you a new password"),
            SizedBox(height: 20),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                label: Text("Email"),
                hintText: "Email",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                floatingLabelStyle:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusColor: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () async {
                String email = _emailController.text.trim();
                if (email.isEmpty || email == "") {
                  WarningToast(
                    context: context,
                    message: "Please input email",
                  ).ShowToast();
                  return;
                }
                String? respond;
                try {
                  respond = await ForgotPassword(email);
                  SuccessToast(
                    context: context,
                    message: respond!,
                  ).ShowToast();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => SendEmailScreen(email: email)));
                  return;
                } catch (e) {
                  WarningToast(
                    context: context,
                    message: e.toString(),
                  ).ShowToast();
                  return;
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 6),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
                child: Center(
                  child: Text(
                    "Reset password",
                    style: GoogleFonts.manrope(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryFixed,
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
                    MaterialPageRoute(builder: (builder) => SignInScreen()),
                    (dynamic Route) => false);
              },
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).colorScheme.primary,
                      size: 24,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Back to login",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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
