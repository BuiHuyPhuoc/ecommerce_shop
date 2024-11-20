import 'package:ecommerce_shop/theme/theme.dart';
import 'package:ecommerce_shop/theme/theme_provider.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
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

  List<ThemeData> themeData = [ThemeData(colorScheme: blueColorScheme)];

  @override
  void initState() {
    isDarkmode = Provider.of<ThemeProvider>(context, listen: false)
            .themeData
            .brightness ==
        Brightness.dark;
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
              ),
              Text(
                "Accent Color",
                style: GoogleFonts.manrope(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              SizedBox(height: 10),
              Container(
                height: 40,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return AccentColorItem(themeData[index]);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 10);
                  },
                  itemCount: themeData.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget AccentColorItem(ThemeData themeData) {
    bool isCurrentTheme = false;
    if (Provider.of<ThemeProvider>(context, listen: false).themeData ==
        themeData) {
      isCurrentTheme = true;
    }
    return AspectRatio(
      aspectRatio: 1 / 1,
      child: GestureDetector(
        onTap: () {
          Provider.of<ThemeProvider>(context, listen: false)
              .toggleTheme((!isCurrentTheme) ? themeData : lightMode);
          NotifyToast(
            context: context,
            message: "Change theme",
          ).ShowToast();
          setState(() { 
            isDarkmode = false;
          });
        },
        child: Container(
          padding: EdgeInsets.all(2),
          clipBehavior: Clip.none,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: (isCurrentTheme)
                ? Border.all(
                    color: Theme.of(context).colorScheme.outline,
                    width: 2,
                  )
                : Border(),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: themeData.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
