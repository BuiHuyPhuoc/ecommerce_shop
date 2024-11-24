import 'package:ecommerce_shop/screens/admin/admin_show_order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Welcome, Admin",
          style: GoogleFonts.manrope(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ReportCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => AdminShowOrder(),
                          ),
                        );
                      },
                      context: context,
                      title: "Order",
                      icon: Icon(
                        Icons.assignment,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      value: 10,
                    ),
                    SizedBox(width: 10),
                    ReportCard(
                      context: context,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .secondaryContainer
                          .withOpacity(0.3),
                      title: "Rating",
                      icon: Icon(
                        Icons.star_rounded,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      value: 4.3,
                      content: "Rate for your product!",
                    ),
                    SizedBox(width: 10),
                    ReportCard(
                      context: context,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.3),
                      title: "Review",
                      icon: Icon(
                        Icons.rate_review,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      value: 100,
                      content: "Reviews for your product!",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget ReportCard(
      {required BuildContext context,
      Icon? icon,
      required String title,
      String? content,
      required double value,
      Color? backgroundColor,
      VoidCallback? onTap}) {
    return AspectRatio(
      aspectRatio: 10 / 11,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: backgroundColor ??
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.6),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  icon ??
                      Icon(
                        Icons.assignment,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                  SizedBox(width: 6),
                  Text(
                    title,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  )
                ],
              ),
              Text(
                value.toString(),
                style: GoogleFonts.roboto(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Text(
                content ?? "Manage your order now!",
                maxLines: 3, // Giới hạn số dòng hiển thị (ở đây là 2 dòng)
                overflow:
                    TextOverflow.ellipsis, // Hiển thị dấu ba chấm khi quá dài
                style: GoogleFonts.lexendDeca(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
