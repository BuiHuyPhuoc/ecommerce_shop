import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/screens/cart_screen.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/screens/setting_screen.dart';
import 'package:ecommerce_shop/screens/search_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/customer_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class NavigationScreen extends StatefulWidget {
  NavigationScreen({super.key, this.pageNumber = 0});

  int pageNumber;

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late CustomerDTO? nameUser;
  bool isLoading = true;
  void GetUser() async {
    nameUser = await GetCustomerDTOByJwtToken();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (nameUser == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => SignInScreen()),
            (dynamic Route) => false);
      });
    }
    List<Widget> screens = [
      HomeScreen(
        customerDTO: nameUser!,
      ),
      SearchScreen(
        customerDTO: nameUser!,
      ),
      CartScreen(
        customerDTO: nameUser!,
      ),
      SettingScreen(
        customerDTO: nameUser!,
      )
    ];

    Color iconColor = Theme.of(context).colorScheme.onPrimaryFixed;
    return Scaffold(
      body: screens[widget.pageNumber],
      bottomNavigationBar: GNav(
        duration: Duration(milliseconds: 600),
        selectedIndex: widget.pageNumber,
        gap: 10,
        textStyle: GoogleFonts.manrope(
            fontSize: 18, color: Theme.of(context).colorScheme.onPrimaryFixed),
        iconSize: 24,
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        tabs: [
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 0;
              });
            },
            icon: Icons.home_outlined,
            text: 'Home',
            iconColor: iconColor,
            iconActiveColor: iconColor,
            textColor: iconColor,
          ),
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 1;
              });
            },
            icon: Icons.search,
            text: 'Search',
            iconColor: iconColor,
            iconActiveColor: iconColor,
            textColor: iconColor,
          ),
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 2;
              });
            },
            icon: Icons.shopping_cart_outlined,
            text: 'Cart',
            iconColor: iconColor,
            iconActiveColor: iconColor,
            textColor: iconColor,
          ),
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 3;
              });
            },
            icon: Icons.person_outline_rounded,
            text: 'Profile',
            iconColor: iconColor,
            iconActiveColor: iconColor,
            textColor: iconColor,
          )
        ],
      ),
    );
  }
}
