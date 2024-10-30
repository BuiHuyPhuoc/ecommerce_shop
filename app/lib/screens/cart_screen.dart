import 'package:ecommerce_shop/class/string_format.dart';
import 'package:ecommerce_shop/models/cart.dart';
import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/services/cart_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
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
            Container(
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
    return Container(
      width: double.infinity,
      height: 140,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
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
                        cart.idProductVarientNavigation.idProductNavigation!
                            .nameProduct,
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
                    "Size: " + cart.idProductVarientNavigation.size.toString(),
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
                              : Container(),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black26, width: 1),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "1",
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                          ),
                          Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 20,
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
    );
  }
}
