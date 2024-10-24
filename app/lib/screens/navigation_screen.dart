import 'package:ecommerce_shop/screens/cart_screen.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/screens/setting_screen.dart';
import 'package:ecommerce_shop/screens/search_screen.dart';
import 'package:flutter/material.dart';
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
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    CartScreen(),
    SettingScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[widget.pageNumber],
      bottomNavigationBar: GNav(
        duration: Duration(milliseconds: 600),
        selectedIndex: widget.pageNumber,
        gap: 10,
        textStyle: GoogleFonts.manrope(
            fontSize: 18, color: Theme.of(context).colorScheme.primary),
        iconSize: 24,
        backgroundColor: Theme.of(context).colorScheme.surface,
        tabs: [
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 0;
              });
            },
            icon: Icons.home_outlined,
            text: 'Home',
            iconColor: Theme.of(context).colorScheme.primary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 1;
              });
            },
            icon: Icons.search,
            text: 'Search',
            iconColor: Theme.of(context).colorScheme.primary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 2;
              });
            },
            icon: Icons.shopping_cart_outlined,
            text: 'Cart',
            iconColor: Theme.of(context).colorScheme.primary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.primary,
          ),
          GButton(
            onPressed: () {
              setState(() {
                widget.pageNumber = 3;
              });
            },
            icon: Icons.person_outline_rounded,
            text: 'Profile',
            iconColor: Theme.of(context).colorScheme.primary,
            iconActiveColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.primary,
          )
        ],
      ),
    );
  }
}
