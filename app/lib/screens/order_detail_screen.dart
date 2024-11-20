import 'dart:async';
import 'package:ecommerce_shop/class/string_format.dart';
import 'package:ecommerce_shop/models/order.dart';
import 'package:ecommerce_shop/models/order_detail.dart';
import 'package:ecommerce_shop/services/auth_services.dart';
import 'package:ecommerce_shop/services/order_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return FutureBuilder(
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
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: CustomAppBar(
                    context: context,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    title: "Your order"),
                body: ShowDetailOrder(context, getOrder),
                bottomNavigationBar: IntrinsicHeight(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        "Total " +
                            StringFormat.ConvertMoneyToString(getOrder.amount),
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }
        }

        return Center(
          child: Text("Error when get order"),
        );
      },
    );
  }

  Widget ShowDetailOrder(BuildContext context, Order getOrder) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.primaryFixed,
                      size: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Receiver",
                          style: GoogleFonts.manrope(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: Theme.of(context).colorScheme.background,
                      size: 30,
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            getOrder.idAddressNavigation.receiverName +
                                " | " +
                                getOrder.idAddressNavigation.receiverPhone,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          Text(
                            getOrder.idAddressNavigation.street,
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                          Text(
                            "${getOrder.idAddressNavigation.ward}, ${getOrder.idAddressNavigation.district}, ${getOrder.idAddressNavigation.city}",
                            style: GoogleFonts.roboto(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Products",
            style: GoogleFonts.manrope(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Container(
            child: Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return OrderDetailItem(
                    context,
                    getOrder.orderDetails![index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: getOrder.orderDetails!.length,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget OrderDetailItem(BuildContext context, OrderDetail detail) {
    return Container(
      width: double.infinity,
      height: 140,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    detail.idProductNavigation!.imageProduct,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    detail.productName,
                    style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            StringFormat.ConvertMoneyToString(
                                detail.salePrice ?? detail.productPrice),
                            style: GoogleFonts.manrope(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: RichText(
                        textAlign: TextAlign.end,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: 'Amount: ',
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Theme.of(context).colorScheme.primaryFixed,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: detail.quantity.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryFixed),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
