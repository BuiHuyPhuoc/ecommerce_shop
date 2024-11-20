import 'dart:async';
import 'package:ecommerce_shop/models/order.dart';
import 'package:ecommerce_shop/screens/order_detail_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/order_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  late Future<List<Order>> _listOrders;
  void GetData() async {
    _listOrders = GetOrder();
  }

  @override
  void initState() {
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.hasError) {
            if (snapshot.error.runtimeType == TimeoutException) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                WarningToast(
                  context: context,
                  message: snapshot.error.toString(),
                ).ShowToast();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignInScreen()),
                    (dynamic Route) => false);
              });
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                WarningToast(
                  context: context,
                  message: snapshot.error.toString(),
                  duration: Duration(seconds: 3),
                ).ShowToast();
              });

              return Scaffold(
                body: Container(
                  child: Center(
                    child: Text("Failed to get order"),
                  ),
                ),
              );
            }
          }

          if (snapshot.hasData) {
            List<Order> _orders = snapshot.data ?? [];
            return Scaffold(
              appBar: CustomAppBar(
                context: context,
                title: "Order history",
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body: Container(
                padding: EdgeInsets.all(20),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ItemHistoryOrder(_orders[index]);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: _orders.length,
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Container(
                child: Center(
                  child: Text("Failed to get order"),
                ),
              ),
            );
          }
        }
      },
    );
  }

  Widget ItemHistoryOrder(Order order) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.outline,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              image: DecorationImage(
                image: AssetImage("assets/images/booked.png"),
                fit: BoxFit.fill,
              ),
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.outline.withOpacity(0.4),
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderLabel(
                  label: "Date",
                  content: DateFormat('dd-MM-yyyy').format(
                    order.date,
                  ),
                ),
                OrderLabel(
                  label: "Quantiy",
                  content: order.orderDetails!.length.toString(),
                ),
                OrderLabel(
                  label: "Receiver",
                  content: order.idAddressNavigation.receiverName +
                      " | " +
                      order.idAddressNavigation.receiverPhone,
                ),
                OrderLabel(
                  label: "Status",
                  content: order.status,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            border: Border.all(
                                color: Theme.of(context)
                                    .colorScheme
                                    .outline
                                    .withOpacity(0.4),
                                width: 1),
                          ),
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (builder) =>
                                  OrderDetailScreen(idOrder: order.id),
                            ),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primaryFixed,
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                            border: Border.all(
                              color: Theme.of(context)
                                  .colorScheme
                                  .outline
                                  .withOpacity(0.4),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "View ticket",
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryFixed,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget OrderLabel(
      {required String label, required String content, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Text(
            "$label: ",
            style: GoogleFonts.roboto(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          Text(
            content,
            style: GoogleFonts.lexendDeca(
              fontSize: 16,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
