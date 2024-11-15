import 'dart:async';

import 'package:ecommerce_shop/models/order.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/services/order_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OrderDetailScreen extends StatefulWidget {
  OrderDetailScreen({super.key, required this.idOrder});

  int idOrder;

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  late Future<Order> _order;
  void GetData() async {
    _order = GetOrderDetail(widget.idOrder);
    print(_order);
  }

  @override
  void initState() {
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          context: context,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: "Your order"),
      body: FutureBuilder(
        future: _order,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              String errorMessage = snapshot.error.toString();
              if (snapshot.error.runtimeType == TimeoutException) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  NotifyToast(
                    context: context,
                    message: errorMessage,
                  ).ShowToast();
                  Logout(context);
                });
                return SizedBox(); // Trả về widget tạm trong khi xử lý đăng xuất
              } else {
                return Center(
                  child: Text(errorMessage),
                );
              }
            }

            if (snapshot.hasData) {
              Order? getOrder = snapshot.data;
              if (getOrder == null) {
                return Center(
                  child: Text("Order is empty"),
                );
              } else {
                return Center(
                  child: Text("Order is valid"),
                );
              }
            }
          }

          return Center(
            child: Text("Error when get order"),
          );
        },
      ),
    );
  }
}
