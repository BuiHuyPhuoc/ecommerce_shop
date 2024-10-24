import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.red,
            size: 30,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 1),
            ),
            child: Center(
                child: Text(
              "1",
              style: GoogleFonts.lexendDeca(
                fontSize: 12,
                color: Colors.white,
              ),
            )),
          ),
        )
      ],
    );
  }
}
