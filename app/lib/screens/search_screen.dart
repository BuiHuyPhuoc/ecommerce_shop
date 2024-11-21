import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:ecommerce_shop/models/brand.dart';
import 'package:ecommerce_shop/models/category.dart';
import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/models/product.dart';
import 'package:ecommerce_shop/screens/home_screen.dart';
import 'package:ecommerce_shop/services/brand_services.dart';
import 'package:ecommerce_shop/services/category_services.dart';
import 'package:ecommerce_shop/services/product_services.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.customerDTO, this.isFocus = false});

  CustomerDTO customerDTO;
  bool isFocus;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<dynamic>> combinedFuture;
  late Future<List<Brand>> brands;
  late Future<List<Category>> categories;
  List<Product> filteredProducts = [];
  int? idBrand;
  int? idCategory;
  late TextEditingController searchController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController();
    combinedFuture = Future.wait([
      brands = GetAllBrand(),
      categories = GetAllCategory(),
    ]);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> GetFilteredProducts() async {
    String? searchString = searchController.text.trim();
    filteredProducts = await FilterProduct(idCategory, idBrand, searchString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder<List<dynamic>>(
            future: combinedFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                // snapshot.data là một List chứa hai phần tử
                List<Brand> _brands = snapshot.data![0];
                List<Category> _categories = snapshot.data![1];

                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 11,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextField(
                                  autofocus: true,
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 25),
                                    border: InputBorder.none,
                                    hintText: "Find your favorites shoes",
                                    hintStyle: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                try {
                                  await GetFilteredProducts();
                                } catch (e) {
                                  WarningToast(
                                    context: context,
                                    message: e.toString(),
                                  ).ShowToast();
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              child: Container(
                                height: 60,
                                child: AspectRatio(
                                  aspectRatio: 1 / 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryFixed),
                                    child: Center(
                                      child: Icon(
                                        Icons.search,
                                        color: Color(0xffA3FFD6),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Brand",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          _brands.length,
                          (int index) {
                            return ChoiceChip(
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              label: Text(_brands[index].nameBrand),
                              selected: idBrand == _brands[index].id,
                              onSelected: (bool selected) async {
                                setState(() {
                                  idBrand = selected ? _brands[index].id : null;
                                  _isLoading = true;
                                });

                                try {
                                  await GetFilteredProducts();
                                } catch (e) {
                                  WarningToast(
                                    context: context,
                                    message: e.toString(),
                                  ).ShowToast();
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Category",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Wrap(
                        spacing: 5.0,
                        children: List<Widget>.generate(
                          _categories.length,
                          (int index) {
                            return ChoiceChip(
                              selectedColor:
                                  Theme.of(context).colorScheme.primary,
                              label: Text(_categories[index].name),
                              selected: idCategory == _categories[index].id,
                              onSelected: (bool selected) async {
                                setState(() {
                                  idCategory =
                                      selected ? _categories[index].id : null;
                                  _isLoading = true;
                                });

                                try {
                                  await GetFilteredProducts();
                                } catch (e) {
                                  WarningToast(
                                    context: context,
                                    message: e.toString(),
                                  ).ShowToast();
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(height: 10),
                      (_isLoading)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : DynamicHeightGridView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 10,
                              crossAxisCount: 2,
                              builder: (BuildContext context, int index) {
                                return ItemCard(
                                  context: context,
                                  product: filteredProducts[index],
                                );
                              },
                              itemCount: filteredProducts.length,
                            )
                    ],
                  ),
                );
              } else {
                return Center(child: Text('No data available'));
              }
            },
          ),
        ),
      ),
    );
  }
}
