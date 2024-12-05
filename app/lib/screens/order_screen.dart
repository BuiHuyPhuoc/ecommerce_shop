import 'dart:async';
import 'package:ecommerce_shop/class/string_format.dart';
import 'package:ecommerce_shop/models/address.dart';
import 'package:ecommerce_shop/models/cart.dart';
import 'package:ecommerce_shop/models/order_request.dart';
import 'package:ecommerce_shop/screens/select_address_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/address_services.dart';
import 'package:ecommerce_shop/services/order_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class OrderScreen extends StatefulWidget {
  OrderScreen({super.key, required this.listCarts});
  List<Cart> listCarts;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Address? _getAddress = null;
  void GetAddress() async {
    try {
      if (_getAddress == null) {
        _getAddress = await GetDefaultAddress();
      }
    } on TimeoutException catch (e) {
      WarningToast(
        context: context,
        message: e.toString(),
      ).ShowToast();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => SignInScreen()),
          (dynamic Route) => false);
    } catch (e) {
      WarningToast(
        context: context,
        message: e.toString(),
      ).ShowToast();
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    GetAddress();
  }

  @override
  Widget build(BuildContext context) {
    if (_getAddress == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: CustomAppBar(
        context: context,
        title: "Order",
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, 'reload');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddressArea(context),
              SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) =>
                    OrderItem(context, widget.listCarts[index]),
                separatorBuilder: (context, index) => SizedBox(height: 5),
                itemCount: widget.listCarts.length,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    width: 1),
              ),
              color: Theme.of(context).colorScheme.background),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: RichText(
                  textAlign: TextAlign.end,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: 'Total: ',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            StringFormat.ConvertMoneyToString(GetTotalPrice()),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                onTap: () async {
                  List<int> _listIdCart = widget.listCarts
                      .map((toElement) => toElement.id)
                      .toList();
                  if (_getAddress == null) {
                    WarningToast(
                      context: context,
                      message: "Pick receiver",
                    ).ShowToast();
                    return;
                  }
                  if (_getAddress!.id == null) {
                    WarningToast(
                      context: context,
                      message: "Receiver invalid, please choose again",
                    ).ShowToast();
                    return;
                  }
                  OrderRequest newOrder = new OrderRequest(
                      idCarts: _listIdCart,
                      status: "BOOKED",
                      idAddress: _getAddress!.id!);

                  try {
                    LoadingDialog(context);
                    bool check = await AddOrder(newOrder);
                    Navigator.pop(context); // Pop loading circle
                    if (check) {
                      SuccessToast(
                        context: context,
                        message: "Order success",
                      ).ShowToast();
                    } else {
                      WarningToast(
                        context: context,
                        message: "Order failed",
                      ).ShowToast();
                    }
                  } catch (e) {
                    WarningToast(
                      context: context,
                      message: e.toString(),
                    ).ShowToast();
                  } finally {
                    Navigator.pop(
                        context, 'reload'); // Come to previous page and reload
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Order",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AddressArea(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push<Address?>(
          context,
          MaterialPageRoute(
            builder: (context) => SelectAddressScreen(),
          ),
        ).then((Address? onValue) {
          if (onValue != null) {
            setState(() {
              _getAddress = onValue;
            });
          }
        });
      },
      child: Container(
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
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address to receive",
                      style: GoogleFonts.manrope(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
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
                        _getAddress!.receiverName +
                            " | " +
                            _getAddress!.receiverPhone,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        _getAddress!.street,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "${_getAddress!.ward}, ${_getAddress!.district}, ${_getAddress!.city}",
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
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
    );
  }

  double GetTotalPrice() {
    double sumTotal = 0;
    for (var i = 0; i < widget.listCarts.length; i++) {
      sumTotal += (widget.listCarts[i].idProductVarientNavigation
              .idProductNavigation!.newPrice ??
          widget.listCarts[i].idProductVarientNavigation.idProductNavigation!
              .priceProduct)*widget.listCarts[i].quantity;
    }
    return sumTotal;
  }
}

Widget OrderItem(BuildContext context, Cart cart) {
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
                image: NetworkImage(cart.idProductVarientNavigation
                    .idProductNavigation!.imageProduct),
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
              Text(
                cart.idProductVarientNavigation.idProductNavigation!
                    .nameProduct,
                style: GoogleFonts.manrope(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(
                child: Text(
                  "Size: ${cart.idProductVarientNavigation.size}",
                  style: GoogleFonts.manrope(
                    fontSize: 14,
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
                          StringFormat.ConvertMoneyToString(cart
                                  .idProductVarientNavigation
                                  .idProductNavigation!
                                  .newPrice ??
                              cart.idProductVarientNavigation
                                  .idProductNavigation!.priceProduct),
                          style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        (cart.idProductVarientNavigation.idProductNavigation!
                                    .newPrice !=
                                null)
                            ? Text(
                                StringFormat.ConvertMoneyToString(cart
                                    .idProductVarientNavigation
                                    .idProductNavigation!
                                    .priceProduct),
                                style: GoogleFonts.manrope(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary
                                        .withOpacity(0.4),
                                    decoration: TextDecoration.lineThrough,
                                    fontSize: 14),
                              )
                            : SizedBox()
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
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: cart.quantity.toString(),
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(context).colorScheme.primary),
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
