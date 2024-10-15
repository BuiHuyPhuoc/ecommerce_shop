// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentItemWidget extends StatelessWidget {
  PaymentItemWidget(
      {super.key,
      required this.imagePath,
      required this.paymentName,
      this.onTap});
  String imagePath;
  String paymentName;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.background,
          border: Border.all(
              color: Theme.of(context).colorScheme.outline, width: 2),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.contain,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1, color: Theme.of(context).colorScheme.outline),
              ),
              height: 50,
              width: 50,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 7, left: 12, bottom: 2),
                child: Text(
                  paymentName,
                  style: GoogleFonts.montserrat(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
