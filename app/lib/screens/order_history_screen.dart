import 'dart:async';

import 'package:ecommerce_shop/models/order.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/order_services.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

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
            List<Order>? _orders = snapshot.data;
            return Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [],
                  ),
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
}
