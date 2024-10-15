// ignore_for_file: unused_import
import 'package:ecommerce_shop/screens/cart_screen.dart';
import 'package:ecommerce_shop/screens/custom_card.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/screens/navigation_screen.dart';
import 'package:ecommerce_shop/screens/payment_method_screen.dart';
import 'package:ecommerce_shop/screens/product_detail_screen.dart';
import 'package:ecommerce_shop/screens/profile_screen.dart';
import 'package:ecommerce_shop/screens/welcome_screen/welcome_screen1.dart';
import 'package:ecommerce_shop/screens/welcome_screen/welcome_screen2.dart';
import 'package:ecommerce_shop/screens/widgets/item_payment_widget.dart';
import 'package:ecommerce_shop/screens/widgets/select_address_screen.dart';
import 'package:ecommerce_shop/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: ProfileScreen(),
    // );

    return Consumer<ThemeProvider>(builder: (context, ThemeProvider, child) {
      return MaterialApp(
        home: PaymentMethodScreen(),
        theme: ThemeProvider.themeData,
      );
    });
  }
}
