import 'package:ecommerce_shop/models/register_customer.dart';
import 'package:ecommerce_shop/screens/send_email_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/api_services.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignupKey = GlobalKey<FormState>();
  bool agreePersonalData = true;
  TextEditingController fullnameTextField = new TextEditingController();
  TextEditingController emailTextField = new TextEditingController();
  TextEditingController passwordTextField = new TextEditingController();
  TextEditingController phoneNumberTextField = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  bool _isObscure = false;

  @override
  void initState() {
    fullnameTextField.text = "Phước nè";
    emailTextField.text = "buihuyphuoc123@gmail.com";
    passwordTextField.text = "String2k3.";
    phoneNumberTextField.text = "0123123123";
    confirmPasswordController.text = "String2k3.";
    super.initState();
  }

  @override
  void dispose() {
    fullnameTextField.dispose();
    emailTextField.dispose();
    passwordTextField.dispose();
    phoneNumberTextField.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SingleChildScrollView(
            child: Form(
              key: _formSignupKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Đăng ký ngay",
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ), //test
                    TextFormField(
                      controller: fullnameTextField,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Nhập họ tên";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          label: Text("Họ tên"),
                          hintText: "Họ tên",
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          floatingLabelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurface, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusColor: Theme.of(context).colorScheme.onSurface),
                    ),

                    const SizedBox(
                      height: 25.0,
                    ),

                    TextFormField(
                      controller: emailTextField,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text("Email"),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.onSurface),
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

                    const SizedBox(height: 25.0),

                    // Phone Number Field
                    TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: phoneNumberTextField,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Số điện thoại";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text("Số điện thoại"),
                        hintText: "Số điện thoại",
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
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

                    const SizedBox(height: 22.0),

                    //PASSWORD
                    TextFormField(
                      controller: passwordTextField,
                      obscureText: _isObscure,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mật khẩu ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        label: Text("Mật khẩu"),
                        hintText: "Mật khẩu",
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
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
                    const SizedBox(height: 22.0),
                    //PASSWORD
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: _isObscure,
                      obscuringCharacter: '*',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Vui lòng nhập mật khẩu ";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        label: Text("Xác nhận mật khẩu"),
                        hintText: "Xác nhận mật khẩu",
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .shadow, // Default border color
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        floatingLabelStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface, // Default border color
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
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            side: MaterialStateBorderSide.resolveWith(
                              (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return BorderSide(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      width: 2);
                                }
                                return BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    width: 2);
                              },
                            ),
                            value: agreePersonalData,
                            onChanged: (bool? value) {
                              setState(() {
                                agreePersonalData = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Đồng ý với các điều khoản",
                          style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary),
                        )
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll<Color>(
                                Theme.of(context).colorScheme.onSurface)),
                        onPressed: () async {
                          if (_formSignupKey.currentState!.validate() &&
                              agreePersonalData) {
                            LoadingDialog(context);
                            String password = passwordTextField.text.trim();
                            String name = fullnameTextField.text.trim();
                            String email = emailTextField.text.trim();
                            String confirmPassowrd =
                                confirmPasswordController.text.trim();
                            String phone = phoneNumberTextField.text.trim();
                            var newAccount = RegisterCustomer(
                                name: name,
                                email: email,
                                password: password,
                                confirmPassword: confirmPassowrd,
                                phone: phone);
                            ApiRespond respond = await SignUp(newAccount);
                            Navigator.pop(context);
                            if (respond.statusCode == 200) {
                              SuccessToast(
                                context: context,
                                message: respond.message,
                              ).ShowToast();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (builder) =>
                                        SendEmailScreen(email: email),
                                  ),
                                  (dynamic Route) => false);

                              return;
                            } else {
                              WarningToast(
                                context: context,
                                message: respond.message,
                              ).ShowToast();
                              return;
                            }
                          }
                          if (!agreePersonalData) {
                            WarningToast(
                              context: context,
                              message: "Vui lòng đồng ý các điều khoản.",
                              duration: Duration(seconds: 2),
                            ).ShowToast();
                            return;
                          }
                        },
                        child: Text(
                          "Đăng ký",
                          style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.surface),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Đã có tài khoản?",
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (e) => SignInScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    // sign up divider
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Sign in with",
                          style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primary),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Divider(
                            thickness: 0.7,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.google,
                            size: 36,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 36,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: FaIcon(
                            FontAwesomeIcons.github,
                            size: 36,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
