import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/screens/cart_screen.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/screens/setting_screen.dart';
import 'package:ecommerce_shop/screens/search_screen.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/services/customer_services.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
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
  late CustomerDTO? nameUser = null;
  bool isLoading = true;

  Future<void> _initializeUser() async {
    nameUser = await GetCustomerDTOByJwtToken();
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> checkUserAndNavigate(int pageIndex) async {
    // Kiểm tra lại nameUser mỗi lần người dùng thay đổi nav
    await _initializeUser();
    if (nameUser == null) {
      NotifyToast(
        context: context,
        message: "Login time out.",
      ).ShowToast();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Logout(context);
      });
    } else {
      setState(() {
        widget.pageNumber = pageIndex;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (nameUser == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Logout(context);
        });
        return Container();
      }
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
              checkUserAndNavigate(0);
            },
            icon: Icons.home_outlined,
            text: 'Home',
            iconColor: iconColor,
            iconActiveColor: iconColor,
            textColor: iconColor,
          ),
          GButton(
            onPressed: () {
              checkUserAndNavigate(1);
            },
            icon: Icons.search,
            text: 'Search',
            iconColor: iconColor,
            iconActiveColor: iconColor,
            textColor: iconColor,
          ),
          GButton(
            onPressed: () {
              checkUserAndNavigate(2);
            },
            icon: Icons.shopping_cart_outlined,
            text: 'Cart',
            iconColor: iconColor,
            iconActiveColor: iconColor,
            textColor: iconColor,
          ),
          GButton(
            onPressed: () {
              checkUserAndNavigate(3);
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
