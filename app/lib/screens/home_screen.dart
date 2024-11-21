import 'package:carousel_slider/carousel_slider.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_shop/class/string_format.dart';
import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/models/product.dart';
import 'package:ecommerce_shop/screens/product_detail_screen.dart';
import 'package:ecommerce_shop/services/product_services.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required this.customerDTO});
  CustomerDTO customerDTO;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Product> product;
  late List<Product> saleProduct;
  bool isLoading = true;
  List<String> _banners = [
    "assets/images/puma_banner.png",
    "assets/images/adidas_banner.png",
    "assets/images/nike_banner.png",
  ];

  Future<void> GetData() async {
    product = await GetProduct();
    saleProduct = await GetSaleProduct();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    GetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(
        future: GetData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SafeArea(
                      child: HomePageAppBar(context),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CarouselSliderBanner(),
                    SizedBox(height: 10),
                    HomePageHeading(context: context, title: "Giảm giá sâu"),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 300,
                      width: double.infinity,
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return AspectRatio(
                              aspectRatio: 5 / 8,
                              child: ItemCard(
                                  context: context,
                                  product: saleProduct[index]),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              width: 10,
                            );
                          },
                          itemCount: saleProduct.length),
                    ),
                    SizedBox(height: 10),
                    HomePageHeading(context: context, title: "Các sản phẩm"),
                    SizedBox(
                      height: 10,
                    ),
                    DynamicHeightGridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      builder: (BuildContext context, int index) {
                        return ItemCard(
                            context: context, product: product[index]);
                      },
                      itemCount: product.length,
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text("Error"),
            );
          }
        },
      ),
    );
  }

  Widget HomePageHeading(
      {required BuildContext context, String title = "", VoidCallback? onTap}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            title,
            style: GoogleFonts.manrope(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              "Xem thêm",
              style: GoogleFonts.manrope(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
              ),
            ),
          ),
        ],
      ),
    );
  }

  HomePageAppBar(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.customerDTO.avatarImageUrl),
                  fit: BoxFit.fill,
                ),
                border: Border.all(color: Colors.white, width: 2)),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.customerDTO.name,
                  style: GoogleFonts.varela(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  "Welcome back",
                  style: GoogleFonts.manrope(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget CarouselSliderBanner() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
      ),
      items: _banners.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  image:
                      DecorationImage(image: AssetImage(i), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(10)),
            );
          },
        );
      }).toList(),
    );
  }
}

Widget ItemCard({required BuildContext context, required Product product}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (builder) =>
                  ProductDetailScreen(idProduct: product.id)));
    },
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              AspectRatio(
                aspectRatio: 8 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        image: NetworkImage(product.imageProduct),
                        fit: BoxFit.fill),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.favorite_border, color: Colors.black),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    child: Text(
                      product.idBrandNavigation.nameBrand,
                      style: GoogleFonts.montserrat(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  product.nameProduct,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary),
                ),
              ),
              SizedBox(width: 5),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  SizedBox(width: 2),
                  Text(
                    "4.2",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  )
                ],
              ),
            ],
          ),
          (product.newPrice != null)
              ? Text(
                  StringFormat.ConvertMoneyToString(product.newPrice!),
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                )
              : Text(
                  StringFormat.ConvertMoneyToString(product.priceProduct),
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
          SizedBox(
            width: 10,
          ),
          (product.newPrice != null && product.newPrice != product.priceProduct)
              ? Text(
                  "2.000.000đ",
                  style: GoogleFonts.manrope(
                    fontSize: 12,
                    color:
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              : Container()
        ],
      ),
    ),
  );
}
