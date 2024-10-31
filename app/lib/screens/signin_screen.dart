// ignore_for_file: must_be_immutable

import 'package:ecommerce_shop/screens/navigation_screen.dart';
import 'package:ecommerce_shop/screens/signup_screen.dart';
import 'package:ecommerce_shop/widgets/custom_text_field.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key, this.email = "", this.password = ""});

  String email;
  String password;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isObscure = true;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    _emailController = new TextEditingController();
    _passwordController = new TextEditingController();
    // _emailController.text = widget.email;
    // _passwordController.text = widget.password;
    _emailController.text = "buihuyphuoc123@gmail.com";
    _passwordController.text = "String2k3.";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Don\'t have account?",
                        style: GoogleFonts.manrope(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryFixed,
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryFixed,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/shoe_icon.png"),
                    ),
                  ),
                ),
                Text(
                  "LOGIN",
                  style: GoogleFonts.manrope(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "And start shopping by your style",
                  style: GoogleFonts.manrope(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomTextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp("^[\u0000-\u007F]+\$"),
                      )
                    ],
                    obscureText: false,
                    enableSuggestions: false,
                    controller: _emailController,
                    prefixIcon: Icon(
                      Icons.attach_email_rounded,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    context: context,
                    hintText: "Email"),
                SizedBox(
                  height: 16,
                ),
                CustomTextField(
                  controller: _passwordController,
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  context: context,
                  hintText: "Password",
                  obscureText: _isObscure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => ValidateAccountAndSignIn(),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        (MaterialPageRoute(
                            builder: (builder) => SignUpScreen())),
                        (dynamic Route) => false);
                  },
                  child: Text(
                    "Forgot password?",
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context)
                          .colorScheme
                          .primaryFixed
                          .withOpacity(0.6),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ValidateAccountAndSignIn() async {
    final String _email = _emailController.text.toString().trim();
    final String _password = _passwordController.text.toString().trim();
    if (_email.isEmpty ||
        _email.length == 0 ||
        _password.isEmpty ||
        _password.length == 0) {
      WarningToast(
        context: context,
        message: "Vui lòng nhập đủ thông tin",
      ).ShowToast();
      return;
    } else {
      LoadingDialog(context);
      bool result = await LoginWithEmailAndPassword(_email, _password);
      Navigator.pop(context);
      if (result) {
        SuccessToast(
          context: context,
          message: "Đăng nhập thành công",
        ).ShowToast();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => NavigationScreen()),
            (Route<dynamic> route) => false);
      } else {
        WarningToast(
          context: context,
          message: "Sai thông tin đăng nhập",
        ).ShowToast();
        return;
      }
    }
  }
}
