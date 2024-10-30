// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget CustomAppBar(
    {required BuildContext context,
    Widget? leading,
    String title = "",
    List<Widget>? actions,
    bool centerTitle = true}) {
  return AppBar(
    //leadingWidth: 30,
    centerTitle: centerTitle,
    backgroundColor: Theme.of(context).colorScheme.background,
    scrolledUnderElevation: 0,
    elevation: 0.0,
    leading: leading,
    title: Text(
      title,
      style: GoogleFonts.manrope(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    actions: actions,
  );
}
