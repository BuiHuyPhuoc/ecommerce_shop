import 'package:ecommerce_shop/class/string_format.dart';
import 'package:ecommerce_shop/models/product_detail.dart';
import 'package:ecommerce_shop/services/product_services.dart';
import 'package:ecommerce_shop/widgets/cart_button.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen({super.key, required this.idProduct});
  int idProduct;
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  Future<ProductDetail>? product;
  int? selectedVarient;

  int quantity = 1;
  void GetData() async {
    product = GetProductDetail(widget.idProduct);
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: product,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          ProductDetail? getProduct = snapshot.data;
          if (getProduct == null) {
            return Center(
              child: Text("Error"),
            );
          } else {
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: CustomAppBar(
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back),
                    ),
                    context: context,
                    title: "Poduct Details",
                    actions: [CartButton()]),
                body: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 380,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(getProduct.imageProduct),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      getProduct.idCategoryNavigation.name,
                                      style: GoogleFonts.manrope(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black54),
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        "4.2",
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                getProduct.nameProduct,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                              SizedBox(height: 20),
                              Text(
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                getProduct.description,
                                style: GoogleFonts.manrope(
                                    fontSize: 16, color: Colors.black54),
                              ),
                              SizedBox(height: 20),
                              Text(
                                "Size",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 10),
                              Container(
                                height: 48,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: getProduct.productVarients.length,
                                  itemBuilder: (context, index) {
                                    return AspectRatio(
                                      aspectRatio: 1 / 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (selectedVarient == index) {
                                            setState(() {
                                              selectedVarient = null;
                                            });
                                          } else {
                                            setState(() {
                                              selectedVarient = index;
                                            });
                                          }
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: (selectedVarient == index)
                                                  ? Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                  : Theme.of(context)
                                                      .colorScheme
                                                      .primary
                                                      .withOpacity(0.4),
                                              shape: BoxShape.circle),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              getProduct
                                                  .productVarients[index].size
                                                  .toString(),
                                              style: GoogleFonts.manrope(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(
                                      width: 10,
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                bottomNavigationBar: IntrinsicHeight(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    StringFormat.ConvertMoneyToString(
                                      (getProduct.newPrice ??
                                              getProduct.priceProduct) *
                                          quantity,
                                    ),
                                    style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  (getProduct.newPrice != null)
                                      ? Text(
                                          StringFormat.ConvertMoneyToString(
                                            getProduct.priceProduct * quantity,
                                          ),
                                          style: GoogleFonts.manrope(
                                            decoration:
                                                TextDecoration.lineThrough,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.6),
                                          ),
                                        )
                                      : Container()
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
                                  Container(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity--;
                                        });
                                      },
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 0),
                                      icon: Icon(
                                        Icons.remove,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: Text(
                                      quantity.toString(),
                                      style: GoogleFonts.roboto(fontSize: 16),
                                    ),
                                  ),
                                  Container(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6, vertical: 0),
                                      icon: Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            if (selectedVarient == null) {
                              NotifyToast(
                                context: context,
                                message: "Please pick up the size",
                              ).ShowToast();
                              return;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Theme.of(context).colorScheme.primary),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Add to cart",
                                style: GoogleFonts.manrope(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return Scaffold(
            body: Center(
              child: Text("Error"),
            ),
          );
        }
      },
    );
  }
}
