import 'package:ecommerce_shop/const.dart';
import 'package:ecommerce_shop/widgets/cart_button.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
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
  List<int> _shoeSize = [36, 37, 38, 39];
  List<String> getImages = [];
  List<int> getVarients = [];
  void GetData() {
    
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
          ),
          context: context,
          title: "Poduct Details",
          actions: [
            CartButton()
          ]
        ),
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
                      image:
                          AssetImage("assets/images/AIR+FORCE+1+'07 (1).png"),
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
                            "Giầy thời trang",
                            style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          )),
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
                        "Nike Air Force 1 Super Long Name",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(height: 20),
                      Text(
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        LoremString(),
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
                      Container(
                        height: 48,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _shoeSize.length,
                          itemBuilder: (context, index) {
                            return AspectRatio(
                              aspectRatio: 1 / 1,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.primary,
                                    shape: BoxShape.circle),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    _shoeSize[index].toString(),
                                    style: GoogleFonts.manrope(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
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
                      child: Text(
                        "1.200.000đ",
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black26, width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 0),
                              icon: Icon(
                                Icons.remove,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              "1",
                              style: GoogleFonts.roboto(fontSize: 16),
                            ),
                          ),
                          Container(
                            child: IconButton(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 0),
                              icon: Icon(
                                Icons.add,
                                color: Colors.black,
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Container(
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
