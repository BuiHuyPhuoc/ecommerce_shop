import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/item_payment_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    List<PaymentItemWidget> _listPaymentName = [
      PaymentItemWidget(
        imagePath: "assets/images/vnpay_logo.png",
        paymentName: "VNPay",
        onTap: () {
          NotifyToast(
            context: context,
            message: "Chức năng đang phát triển",
          ).ShowToast();
          return;
        },
      ),
      PaymentItemWidget(
        imagePath: "assets/images/paypal_logo.png",
        paymentName: "Paypal",
        onTap: () {
          NotifyToast(
            context: context,
            message: "Chức năng đang phát triển",
          ).ShowToast();
          return;
        },
      ),
      PaymentItemWidget(
        imagePath: "assets/images/stripe_logo.png",
        paymentName: "Stripe",
        onTap: () async {
          //try {
          //   bool result = await StripeService.instance
          //       .makePayment(widget.booking.bookingPrice.toInt());
          //   if (result) {
          //     widget.booking.bookingStatus = "Paid";
          //     createBooking(widget.booking);

          //     Navigator.pushAndRemoveUntil(
          //         context,
          //         MaterialPageRoute(builder: (context) => SuccessPage()),
          //         (Route<dynamic> route) => false);
          //   } else {
          //     WarningToast(
          //             context: context,
          //             content: AppLocalizations.of(context)!.errorWarning)
          //         .ShowToast();
          //   }
          // } catch (e) {
          //   print(e);
          //   WarningToast(
          //           context: context,
          //           content: AppLocalizations.of(context)!.errorWarning)
          //       .ShowToast();
          // }
        },
      ),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          //backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Align(
            alignment: Alignment.centerLeft,
            child: Center(
              child: Text(
                "Choose payment method",
                style: GoogleFonts.manrope(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              _buildListPayment(context, _listPaymentName),
            ],
          ),
        ),
        bottomNavigationBar: BackButton(context),
      ),
    );
  }

  Widget _buildListPayment(
      BuildContext context, List<PaymentItemWidget> _listPaymentName) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20,
        );
      },
      itemCount: 3,
      itemBuilder: (context, index) {
        return _listPaymentName[index];
      },
    );
  }

  Widget BackButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text("Xác nhận thoát?"),
              content: Text(
                  "Nếu thoát bây giờ, đơn của bạn sẽ không được ghi nhận lại."),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context); // Pop dialog
                    Navigator.pop(context); // Pop current widget
                    WarningToast(
                      context: context,
                      message: "Đơn đặt của bạn đã bị huỷ.",
                    ).ShowToast();
                  },
                  child: Text(
                    "Accept",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
              ],
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Theme.of(context).colorScheme.primary),
          child: Text(
            "Back",
            style: TextStyle(
                fontSize: 20, color: Theme.of(context).colorScheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
