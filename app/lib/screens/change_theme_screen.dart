import 'package:ecommerce_shop/theme/theme.dart';
import 'package:ecommerce_shop/theme/theme_provider.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ChangeThemeScreen extends StatefulWidget {
  const ChangeThemeScreen({super.key});

  @override
  State<ChangeThemeScreen> createState() => _ChangeThemeScreenState();
}

class _ChangeThemeScreenState extends State<ChangeThemeScreen> {
  bool isDarkmode = false;

  @override
  void initState() {
    isDarkmode = Provider.of<ThemeProvider>(context, listen: false).themeData ==
        darkMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        context: context,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: "Theme",
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Appearance Settings",
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                "Choose your preferred interface appearance.",
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "Light-Dark Mode",
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  Switch(
                      value: isDarkmode,
                      activeColor: Theme.of(context).colorScheme.shadow,
                      trackOutlineColor: WidgetStatePropertyAll<Color>(
                          Theme.of(context).colorScheme.shadow),
                      onChanged: (bool value) {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(isDarkmode ? lightMode : darkMode);
                        setState(() {
                          isDarkmode = !isDarkmode;
                        });
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
