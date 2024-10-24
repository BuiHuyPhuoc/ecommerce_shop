import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/screens/navigation_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/customer_services.dart';
import 'package:flutter/material.dart';

class LoginCheckScreen extends StatefulWidget {
  @override
  _LoginCheckScreenState createState() => _LoginCheckScreenState();
}

class _LoginCheckScreenState extends State<LoginCheckScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    CustomerDTO? customer = await GetCustomerDTOByJwtToken();
    if (customer != null) {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => NavigationScreen()), (dynamic Route) => false); 
    } else {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SignInScreen()), (dynamic Route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
