import 'dart:async';
import 'package:ecommerce_shop/class/string_format.dart';
import 'package:ecommerce_shop/models/cart.dart';
import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/models/order_request.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/cart_services.dart';
import 'package:ecommerce_shop/services/order_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  CartScreen({super.key, required this.customerDTO});
  CustomerDTO customerDTO;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<bool> _indexSelectedProduct;
  int _countSelected = 0;
  late List<Cart> listCarts;
  bool isLoading = true;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void CountSelected() {
    setState(() {
      _countSelected =
          _indexSelectedProduct.where((element) => element == true).length;
    });
  }

  void SelectAll() {
    setState(() {
      _indexSelectedProduct =
          List<bool>.generate(listCarts.length, (index) => true);
      _countSelected =
          _indexSelectedProduct.where((element) => element == true).length;
    });
  }

  void RemoveAll() {
    setState(() {
      _indexSelectedProduct =
          List<bool>.generate(listCarts.length, (index) => false);
      _countSelected =
          _indexSelectedProduct.where((element) => element == true).length;
    });
  }

  void GetData() async {
    listCarts = await GetCarts();
    _indexSelectedProduct =
        List<bool>.generate(listCarts.length, (index) => false);
    CountSelected();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(context: context, title: "Cart List"),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: listCarts.length,
            itemBuilder: (context, index) {
              return ItemCart(index, listCarts[index]);
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                width: 1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setState(() {
                (_countSelected != listCarts.length)
                    ? SelectAll()
                    : RemoveAll();
              }),
              child: (_countSelected == listCarts.length)
                  ? Icon(
                      Icons.check_box,
                      size: 24,
                    )
                  : Icon(Icons.check_box_outlined, size: 24),
            ),
            SizedBox(width: 6),
            Expanded(
              flex: 1,
              child: Text(
                "Get all",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    fontSize: 16),
              ),
            ),
            Expanded(
              flex: 3,
              child: RichText(
                textAlign: TextAlign.end,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: 'Total: ',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: StringFormat.ConvertMoneyToString(GetTotalPrice()),
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
                List<int> idCarts = [];
                for (int i = 0; i < listCarts.length; i++) {
                  if (_indexSelectedProduct[i]) {
                    idCarts.add(listCarts[i].id);
                  }
                }
                if (idCarts.length == 0) {
                  NotifyToast(
                    context: context,
                    message: "There is no item to buy",
                  ).ShowToast();
                } else {
                  // Address default is 3
                  OrderRequest orderRequest = new OrderRequest(
                      idCarts: idCarts, status: "BOOKED", idAddress: 3);
                  try {
                    bool result = await AddOrder(orderRequest);
                    if (result) {
                      SuccessToast(
                              context: context,
                              message: "Your order has been saved")
                          .ShowToast();
                      setState(() {
                        GetData();
                      });
                    } else {
                      WarningToast(
                              context: context, message: "Create order failed")
                          .ShowToast();
                    }
                  } on TimeoutException catch (e) {
                    WarningToast(context: context, message: e.message ?? "")
                        .ShowToast();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignInScreen(),
                        ),
                        (dynamic Route) => false);
                  } on Exception catch (e) {
                    WarningToast(
                            context: context,
                            message: "Failed: ${e.toString()}")
                        .ShowToast();
                  }
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Buy (${_countSelected.toString()})",
                  style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double GetTotalPrice() {
    double sumTotal = 0;
    for (var i = 0; i < _indexSelectedProduct.length; i++) {
      if (_indexSelectedProduct[i]) {
        sumTotal += listCarts[i]
                .idProductVarientNavigation
                .idProductNavigation!
                .newPrice ??
            listCarts[i]
                .idProductVarientNavigation
                .idProductNavigation!
                .priceProduct;
      }
    }
    return sumTotal;
  }

  Widget ItemCart(int position, Cart cart) {
    late bool isTouching = false;
    return GestureDetector(
      onLongPress: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Delete from cart?',
                style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primaryFixed),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                      "Do you want to remove this product from cart?",
                      style: GoogleFonts.manrope(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primaryFixed,
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Ok'),
                  onPressed: () async {
                    LoadingDialog(context);
                    bool check = await DeleteCart([cart.id]);
                    Navigator.pop(context); // Pop loading circle
                    if (check) {
                      SuccessToast(
                        context: context,
                        message: "Delete success",
                      ).ShowToast();
                    } else {
                      WarningToast(
                        context: context,
                        message: "Delete failed",
                      ).ShowToast();
                    }
                    setState(() {
                      GetData();
                    });
                    Navigator.pop(context); // Pop dialog
                  },
                ),
              ],
            );
          },
        );
      },
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        'Delete from cart?',
                        style: GoogleFonts.manrope(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primaryFixed),
                      ),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text(
                              "Do you want to remove this product from cart?",
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.primaryFixed,
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Approve'),
                          onPressed: () async {
                            LoadingDialog(context);
                            bool check = await DeleteCart([cart.id]);
                            Navigator.pop(context); // Pop loading circle
                            if (check) {
                              SuccessToast(
                                context: context,
                                message: "Delete success",
                              ).ShowToast();
                            } else {
                              WarningToast(
                                context: context,
                                message: "Delete failed",
                              ).ShowToast();
                            }
                            setState(() {
                              GetData();
                            });
                            Navigator.pop(context); // Pop dialog
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Listener(
          onPointerDown: (event) => setState(() {
            isTouching = true;
          }),
          onPointerUp: (event) => setState(() {
            isTouching = false;
          }),
          child: Container(
            width: double.infinity,
            height: 140,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: (isTouching)
                  ? Theme.of(context).colorScheme.surface
                  : Theme.of(context).colorScheme.background,
              border: Border.all(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
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
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              cart.idProductVarientNavigation
                                  .idProductNavigation!.nameProduct,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.manrope(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _indexSelectedProduct[position] =
                                    !_indexSelectedProduct[position];
                                CountSelected();
                              });
                            },
                            child: Container(
                              child: Icon(
                                (_indexSelectedProduct[position])
                                    ? Icons.check_box
                                    : Icons.check_box_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                            ),
                          )
                        ],
                      ),
                      Text(
                        cart.idProductVarientNavigation.idProductNavigation!
                            .idBrandNavigation.nameBrand,
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Size: " +
                              cart.idProductVarientNavigation.size.toString(),
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
                                (cart.idProductVarientNavigation
                                            .idProductNavigation!.newPrice !=
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
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontSize: 14),
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black26, width: 1),
                            ),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    LoadingDialog(context);
                                    bool check = await UpdateCart(
                                        idCart: cart.id, amount: -1);
                                    Navigator.pop(context);
                                    if (check) {
                                      cart.quantity += -1;
                                      if (cart.quantity < 0) {
                                        cart.quantity = 0;
                                      }
                                      setState(() {});
                                    } else {
                                      WarningToast(
                                              context: context,
                                              message: "Update quantity failed")
                                          .ShowToast();
                                    }
                                  },
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6),
                                  child: Text(
                                    cart.quantity.toString(),
                                    style: GoogleFonts.roboto(fontSize: 16),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    try {
                                      LoadingDialog(context);
                                      bool check = await UpdateCart(
                                          idCart: cart.id, amount: 1);
                                      Navigator.pop(context);
                                      if (check) {
                                        cart.quantity += 1;
                                        setState(() {});
                                      } else {
                                        WarningToast(
                                                context: context,
                                                message:
                                                    "Update quantity failed")
                                            .ShowToast();
                                      }
                                    } catch (e) {
                                      WarningToast(
                                        context: context,
                                        message: e.toString(),
                                      ).ShowToast();
                                      return;
                                    }
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
