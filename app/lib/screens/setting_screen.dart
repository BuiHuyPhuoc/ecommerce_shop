// ignore_for_file: deprecated_member_use
import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/screens/navigation_screen.dart';
import 'package:ecommerce_shop/screens/profile_screen.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SettingScreen extends StatefulWidget {
  SettingScreen({super.key, required this.customerDTO});

  CustomerDTO customerDTO;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryFixed,
        title: Text(
          "Settings Profile",
          style: GoogleFonts.manrope(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onPrimaryFixed,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
              color: Color(0xffA3FFD6),
            ),
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Theme.of(context).colorScheme.primaryFixed,
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 3),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  widget.customerDTO.avatarImageUrl),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.customerDTO.name,
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          widget.customerDTO.nameRole,
                          style: GoogleFonts.manrope(
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.onPrimaryFixed,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20, left: 20, bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Settings",
                    style: GoogleFonts.lexendDeca(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  SettingItem(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => ProfileScreen(),
                          ),
                        ).then((onValue) {
                          if (onValue == 'reload') {
                            // Gọi hàm updateUserData trong NavigationScreen
                            (context.findAncestorStateOfType<
                                    NavigationScreenState>())
                                ?.initializeUser();
                          }
                        });
                      },
                      context: context,
                      title: "Personal Information",
                      icons: Icons.person_outline_rounded),
                  SettingItem(
                      context: context,
                      title: "Change theme",
                      icons: Icons.color_lens_outlined),
                  SettingItem(
                      context: context,
                      title: "Order history",
                      icons: Icons.shopping_cart_outlined),
                  SettingItem(
                      context: context,
                      title: "Help desk",
                      icons: Icons.help_outline_outlined),
                  SettingItem(
                      context: context,
                      title: "Ngôn ngữ / Language",
                      icons: Icons.language_outlined),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      Logout(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryFixed,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: double.infinity,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              size: 24,
                              color:
                                  Theme.of(context).colorScheme.onPrimaryFixed,
                            ),
                            SizedBox(width: 10),
                            Text(
                              "Đăng xuất",
                              style: GoogleFonts.manrope(
                                fontSize: 18,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixed,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget SettingItem(
      {required BuildContext context,
      required IconData icons,
      required String title,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icons,
              color: Theme.of(context).colorScheme.primary,
              size: 24,
              weight: 0.2,
              grade: 0.2,
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.1),
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_rounded),
                    SizedBox(width: 20)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
