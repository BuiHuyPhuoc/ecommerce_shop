import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  int _selectedOption = 1;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(
            context: context,
            title: "Chọn địa chỉ nhận hàng",
            leading: IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_back),
            ),
            centerTitle: false),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  "Địa chỉ",
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  children: [
                    AddressItemChoice(1),
                    AddressItemChoice(2),
                    AddressItemChoice(3),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Theme.of(context).colorScheme.background,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        color: Theme.of(context).colorScheme.primary,
                        size: 26,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Thêm địa chỉ mới",
                        style: GoogleFonts.manrope(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Theme.of(context).colorScheme.background,
            child: Center(
              child: Text(
                "XÁC NHẬN",
                style: GoogleFonts.manrope(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget AddressItemChoice(int value) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedOption = value;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio<int>(
                    value: value,
                    groupValue: _selectedOption,
                    onChanged: (value) {
                      setState(() {
                        _selectedOption = value!;
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Theme.of(context)
                              .colorScheme
                              .outlineVariant
                              .withOpacity(0.2),
                          width: 1),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Huy Phước",
                          style: GoogleFonts.manrope(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary),
                          children: [
                            TextSpan(
                              text: "   |   ",
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                              ),
                            ),
                            TextSpan(
                              text: "0334379439",
                              style: GoogleFonts.manrope(
                                fontSize: 14,
                                color: Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                      ),
                      Text("119, đường Giác Đạo"),
                      Text("xã Trung Chánh, huyện Hóc Môn, TP.Hồ Chí Minh")
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                NotifyToast(
                  context: context,
                  message: "Chức năng hiện chưa khả dụng",
                ).ShowToast();
              },
              child: Text(
                "Sửa",
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  color: Colors.red,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
