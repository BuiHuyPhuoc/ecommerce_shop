import 'package:ecommerce_shop/models/product.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<Product> _product;
  late List<bool> _indexSelectedProduct;
  int _countSelected = 0;

  void CountSelected() {
    setState(() {
      _countSelected =
          _indexSelectedProduct.where((element) => element == true).length;
    });
  }

  void SelectAll() {
    setState(() {
      _indexSelectedProduct =
          List<bool>.generate(_product.length, (index) => true);
      _countSelected =
          _indexSelectedProduct.where((element) => element == true).length;
    });
  }

  void RemoveAll() {
    setState(() {
      _indexSelectedProduct =
          List<bool>.generate(_product.length, (index) => false);
      _countSelected =
          _indexSelectedProduct.where((element) => element == true).length;
    });
  }

  @override
  void initState() {
    _product = [
      Product(
          nameProduct: "Nike nè",
          brandProduct: "Nike",
          price: 1000000,
          salePrice: 900000),
      Product(
          nameProduct: "Nike nè",
          brandProduct: "Nike",
          price: 1000000,
          salePrice: 900000),
      Product(
          nameProduct: "Adidas nè",
          brandProduct: "Adidas",
          price: 1000000,
          salePrice: 900000),
      Product(
          nameProduct: "Adidas nè",
          brandProduct: "Adidas",
          price: 1000000,
          salePrice: 900000),
      Product(
          nameProduct: "Puma nè",
          brandProduct: "Puma",
          price: 1000000,
          salePrice: 900000),
      Product(
          nameProduct: "Puma nè",
          brandProduct: "Puma",
          price: 1000000,
          salePrice: 900000),
      Product(
          nameProduct: "Decathlon nè",
          brandProduct: "Decathlon",
          price: 1000000,
          salePrice: 900000)
    ];
    _indexSelectedProduct =
        List<bool>.generate(_product.length, (index) => false);
    CountSelected();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(context: context, title: "Cart List"),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: ListView.separated(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: _product.length,
            itemBuilder: (context, index) {
              return CartItem(index, _product[index]);
            },
            separatorBuilder: (context, index) => SizedBox(
              height: 10,
            ),
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
                (_countSelected != _product.length) ? SelectAll() : RemoveAll();
              }),
              child: (_countSelected == _product.length)
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
                "Tất cả",
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
                  text: 'Tổng thanh toán: ',
                  style: GoogleFonts.manrope(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: '10.000.000đ',
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
                "Mua (${_countSelected.toString()})",
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

  Widget CartItem(int position, Product product) {
    return Container(
      width: double.infinity,
      height: 120,
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
                  image: AssetImage("assets/images/AIR+FORCE+1+'07 (1).png"),
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
                        product.nameProduct,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.manrope(
                          fontSize: 18,
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
                Expanded(
                  child: Text(
                    product.brandProduct,
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.6),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.salePrice.toString(),
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
                          Icon(
                            Icons.remove,
                            color: Colors.black,
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
