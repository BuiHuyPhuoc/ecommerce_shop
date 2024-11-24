import 'dart:async';
import 'package:dio/dio.dart';
import 'package:ecommerce_shop/class/string_format.dart';
import 'package:ecommerce_shop/models/post_review_request.dart';
import 'package:ecommerce_shop/models/product.dart';
import 'package:ecommerce_shop/models/review.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/cart_services.dart';
import 'package:ecommerce_shop/services/product_services.dart';
import 'package:ecommerce_shop/services/review_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
  double ratingStar = 0.0;
  late TextEditingController commentController;

  int quantity = 1;
  void GetData() async {
    product = GetProductDetail(widget.idProduct);
  }

  @override
  void initState() {
    GetData();
    commentController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
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
                backgroundColor: Theme.of(context).colorScheme.background,
                appBar: CustomAppBar(
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  context: context,
                  title: "Poduct Details",
                  //actions: [CartButton()],
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withOpacity(0.8),
                                      ),
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
                                        GetAverageRating(getProduct.reviews)
                                            .toStringAsFixed(1),
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
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              SizedBox(height: 10),
                              Text(
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                getProduct.description,
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primary
                                      .withOpacity(0.8),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Size",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
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
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                              ),
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
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Rating",
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .primaryFixed,
                                ),
                              ),
                              CommentSecction(context, getProduct),
                              SizedBox(height: 10),
                              Text(
                                "Review",
                                style: GoogleFonts.manrope(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return RatingComment(
                                      context, getProduct.reviews[index]);
                                },
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 5),
                                itemCount: getProduct.reviews.length,
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
                      color: Theme.of(context).colorScheme.background,
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
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.outline,
                                    width: 1),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6),
                                    child: Text(
                                      quantity.toString(),
                                      style: GoogleFonts.roboto(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                          onTap: () async {
                            if (quantity == 0) {
                              NotifyToast(
                                context: context,
                                message: "Please pick at least 1 quantity",
                              ).ShowToast();
                              return;
                            }
                            if (selectedVarient == null) {
                              NotifyToast(
                                context: context,
                                message: "Please pick up the size",
                              ).ShowToast();
                              return;
                            } else {
                              try {
                                LoadingDialog(context);
                                bool check = await AddToCart(
                                    quantity: quantity,
                                    idProductVarient: getProduct
                                        .productVarients[selectedVarient!].id);
                                Navigator.pop(context);
                                if (check) {
                                  SuccessToast(
                                          context: context,
                                          message: "Add to cart success")
                                      .ShowToast();
                                } else {
                                  WarningToast(
                                    context: context,
                                    message:
                                        "Add to cart failed. Please retry later.",
                                  ).ShowToast();
                                }
                              } catch (e) {
                                WarningToast(
                                  context: context,
                                  message: e.toString(),
                                ).ShowToast();
                              }
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
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

  Widget CommentSecction(BuildContext context, ProductDetail product) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RatingStars(
            value: ratingStar,
            onValueChanged: (v) {
              setState(() {
                ratingStar = v;
              });
            },
            starBuilder: (index, color) => Icon(
              Icons.star_rounded,
              color: color,
              size: 30,
            ),
            starCount: 5,
            starSize: 30,
            maxValue: 5,
            starSpacing: 1,
            maxValueVisibility: true,
            valueLabelVisibility: false,
            animationDuration: Duration(milliseconds: 800),
            starOffColor: Color.fromARGB(255, 207, 207, 207),
            starColor: Colors.yellow,
          ),
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              maxLines: 2,
              controller: commentController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
                hintText: "Leave your rating",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ),
              ),
            ),
          ),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.centerRight,
            child: IntrinsicWidth(
              child: GestureDetector(
                onTap: () async {
                  String content = commentController.text.trim();
                  if (ratingStar == 0) {
                    NotifyToast(
                      context: context,
                      message: "Please rate star",
                    ).ShowToast();
                    return;
                  }
                  if (content.length == 0) {
                    NotifyToast(
                      context: context,
                      message: "Please leave review",
                    ).ShowToast();
                    return;
                  }
                  PostReviewRequest request = new PostReviewRequest(
                    idProduct: product.id,
                    rating: ratingStar.toInt(),
                    content: content,
                  );

                  try {
                    await PostReview(request);
                    commentController.clear();
                    setState(() {
                      ratingStar = 0;
                      GetData();
                    });
                  } on TimeoutException {
                    WarningToast(
                      context: context,
                      message: "Signin time out",
                    ).ShowToast();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (builder) => SignInScreen()),
                      (dynamic Route) => false,
                    );
                  } catch (e) {
                    WarningToast(
                      context: context,
                      message: e.toString(),
                    ).ShowToast();
                    setState(() {});
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryFixed,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Icon(
                        Icons.send,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimaryFixed,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Send",
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onPrimaryFixed,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget RatingComment(BuildContext context, Review review) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(review.idCustomerNavigation.avatarImageUrl),
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      review.idCustomerNavigation.name,
                      style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      DateFormat('dd/MM/yyyy').format(review.date),
                      style: GoogleFonts.manrope(
                        fontSize: 13,
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.4),
                      ),
                    )
                  ],
                ),
                Row(
                  children: List.generate(
                    review.rating,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 2.0),
                      child: Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  review.content,
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
