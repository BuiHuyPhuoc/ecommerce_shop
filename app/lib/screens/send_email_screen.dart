import 'dart:async';

import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SendEmailScreen extends StatefulWidget {
  const SendEmailScreen({super.key, required this.email});
  final String email;

  @override
  State<SendEmailScreen> createState() => _SendEmailScreenState();
}

class _SendEmailScreenState extends State<SendEmailScreen> {
  late bool _isWatingResendEmail = false;
  Timer? _timer;
  int _remainingTime = 30; // Số giây đếm ngược

  void _activateFor30Seconds() {
    setState(() {
      _isWatingResendEmail = true;
      _remainingTime = 30; // Reset lại thời gian
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
  void dispose() {
    // Hủy timer nếu màn hình bị huỷ
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/email-confirmation.png"),
                    fit: BoxFit.fitHeight),
              ),
            ),
            Text(
              "Vui lòng xác nhận email của bạn \n " +
                  "Chúng tôi đã gửi một email xác nhận đến ${widget.email}. \n" +
                  " Ấn vào đường dẫn để kích hoạt tài khoản.",
              style: GoogleFonts.manrope(
                  fontSize: 16, color: Theme.of(context).colorScheme.primary),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      if (_isWatingResendEmail) {
                        WarningToast(
                          context: context,
                          message: "Thử lại sau $_remainingTime giây",
                        ).ShowToast();
                        return;
                      }
                      if (!_isWatingResendEmail) {
                        try {
                          LoadingDialog(context);
                          await SendNewVerifyEmail(widget.email);
                          _activateFor30Seconds();
                          NotifyToast(
                            context: context,
                            message: "Resend veriy email success",
                          ).ShowToast();
                          Navigator.pop(context);
                          return;
                        } catch (e) {
                          print(e);
                          WarningToast(
                            context: context,
                            message: "Somethings went wrong",
                          ).ShowToast();
                          return;
                        }
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Gửi lại email",
                          style: GoogleFonts.manrope(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          (MaterialPageRoute(
                              builder: (builder) => SignInScreen())),
                          (dynamic Route) => false);
                      return;
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Đăng nhập",
                          style: GoogleFonts.manrope(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
