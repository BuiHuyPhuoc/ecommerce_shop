import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, required this.customerDTO});

  CustomerDTO customerDTO;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("Search Screen"),
      ),
    );
  }
}
