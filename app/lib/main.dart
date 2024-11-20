// ignore_for_file: unused_import
import 'dart:io';
import 'package:ecommerce_shop/firebase_options.dart';
import 'package:ecommerce_shop/models/cart.dart';
import 'package:ecommerce_shop/models/product.dart';
import 'package:ecommerce_shop/screens/add_address_screen.dart';
import 'package:ecommerce_shop/screens/cart_screen.dart';
import 'package:ecommerce_shop/screens/change_theme_screen.dart';
import 'package:ecommerce_shop/screens/custom_card.dart';
import 'package:ecommerce_shop/screens/forgot_password_screen.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/screens/navigation_screen.dart';
import 'package:ecommerce_shop/screens/order_history_screen.dart';
import 'package:ecommerce_shop/screens/order_screen.dart';
import 'package:ecommerce_shop/screens/payment_method_screen.dart';
import 'package:ecommerce_shop/screens/product_detail_screen.dart';
import 'package:ecommerce_shop/screens/profile_screen.dart';
import 'package:ecommerce_shop/screens/setting_screen.dart';
import 'package:ecommerce_shop/screens/send_email_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/screens/signup_screen.dart';
import 'package:ecommerce_shop/screens/test_screen.dart';
import 'package:ecommerce_shop/screens/welcome_screen/welcome_screen1.dart';
import 'package:ecommerce_shop/screens/welcome_screen/welcome_screen2.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/services/storage/storage_service.dart';
import 'package:ecommerce_shop/theme/theme.dart';
import 'package:ecommerce_shop/widgets/item_payment_widget.dart';
import 'package:ecommerce_shop/screens/login_check_screen.dart';
import 'package:ecommerce_shop/screens/select_address_screen.dart';
import 'package:ecommerce_shop/theme/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDznM1m62LdnnVIGLQcF5YPu64nuSJHN6M",
      appId: "1:145730313552:android:55ea23695f29b29901a055",
      messagingSenderId: "145730313552",
      projectId: "shopoes-2e0b8",
    ),
  );
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider, child) {
          return MaterialApp(
            home: NavigationScreen(),
            theme: ThemeProvider.themeData,
          );
        },
      ),
    );
  }
}
