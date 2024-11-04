import 'dart:convert';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_text_field.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:search_choices/search_choices.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isLoading = true;
  final String _provinceHint = "City/Province";
  final String _districtHint = "District";
  final String _wardHint = "Ward";
  String? _province;
  String? _district;
  String? _ward;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  late TextEditingController _streetNumberController;

  late List<Map<String, dynamic>>? _listProvince = null;
  late List<Map<String, dynamic>>? _listDistrict = null;
  late List<Map<String, dynamic>>? _listWard = null;

  Future<void> loadVietnamAddressData() async {
    final String jsonString =
        await rootBundle.loadString('assets/vietnam_address.json');
    final List<dynamic> data = json.decode(jsonString);
    _listProvince = data.map((e) {
      return {
        "name": e["name"] as String,
        "districts": e["districts"] as List<dynamic>
      };
    }).toList();
    setState(() {
      isLoading = false;
    });
    //await loadVietnamDistrictData();
  }

  void loadVietnamDistrictData() async {
    List<dynamic> data = [];
    for (var province in _listProvince!) {
      if (province["name"] == _province) {
        data = province["districts"] as List<dynamic>;
        break;
      }
    }
    _listDistrict = data.map((district) {
      return {
        "name": district["name"] as String,
        "wards": district["wards"] as List<dynamic>
      };
    }).toList();
    setState(() {});
  }

  void loadVietnamWardData() async {
    List<dynamic> data = [];
    for (var district in _listDistrict!) {
      if (district["name"] == _district) {
        data = district["wards"] as List<dynamic>;
        break;
      }
    }
    _listWard = data.map((ward) {
      return {
        "name": ward["name"] as String,
      };
    }).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadVietnamAddressData();
    _nameController = new TextEditingController();
    _phoneNumberController = new TextEditingController();
    _streetNumberController = new TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneNumberController.dispose();
    _streetNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    }

    List<DropdownMenuItem> itemProvince = [];
    List<DropdownMenuItem> itemDistrict = [];
    List<DropdownMenuItem> itemWard = [];
    if (_listProvince != null) {
      for (var province in _listProvince!) {
        itemProvince.add(
          DropdownMenuItem(
            value: province["name"] as String,
            child: Text(province["name"] as String),
          ),
        );
      }
    }

    if (_listDistrict != null) {
      for (var district in _listDistrict!) {
        itemDistrict.add(
          DropdownMenuItem(
            value: district["name"] as String,
            child: Text(district["name"] as String),
          ),
        );
      }
    }

    if (_listWard != null) {
      for (var ward in _listWard!) {
        itemWard.add(
          DropdownMenuItem(
            value: ward["name"] as String,
            child: Text(ward["name"] as String),
          ),
        );
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(context: context, title: "Add Address"),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Contact",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              CustomTextField(
                context: context,
                hintText: "Full name",
                prefixIcon: Icon(
                  Icons.person_rounded,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              SizedBox(height: 10),
              CustomTextField(
                context: context,
                hintText: "Phone number",
                prefixIcon: Icon(
                  Icons.phone,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Address",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.primaryFixed,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.surface),
                child: SearchChoices.single(
                  items: itemProvince,
                  value: _province,
                  hint: _provinceHint,
                  searchHint: _provinceHint,
                  onChanged: (value) async {
                    if (value != null) {
                      setState(() {
                        if (_province != null && _province != value) {
                          _district = null;
                          _ward = null;
                        }
                        _province = value;
                        loadVietnamDistrictData();
                      });
                    }
                  },
                  isExpanded: true,
                  displayClearIcon: false,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.surface),
                child: SearchChoices.single(
                  items: itemDistrict,
                  value: _district,
                  hint: _districtHint,
                  searchHint: _districtHint,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        if (_district != null && _district != value) {
                          _ward = null;
                        }
                        _district = value;
                        loadVietnamWardData();
                      });
                    }
                  },
                  isExpanded: true,
                  displayClearIcon: false,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.surface),
                child: SearchChoices.single(
                  items: itemWard,
                  value: _ward,
                  hint: _wardHint,
                  searchHint: _wardHint,
                  onChanged: (value) {
                    setState(() {
                      _ward = value;
                    });
                  },
                  isExpanded: true,
                  displayClearIcon: false,
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 10),
              CustomTextField(
                context: context,
                hintText: "Home number, Street",
                prefixIcon: Icon(
                  Icons.maps_home_work_rounded,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: IntrinsicHeight(
        child: GestureDetector(
          onTap: () {
            String name = _nameController.text.trim();
            String phone = _phoneNumberController.text.trim();
            String street = _streetNumberController.text.trim();
            if (name == "" || name.length == 0) {
              WarningToast(
                context: context,
                message: "Name is not filled.",
              ).ShowToast();
              return;
            }
            if (phone == "" || phone.length == 0) {
              WarningToast(
                context: context,
                message: "Phone number is not filled.",
              ).ShowToast();
              return;
            }
            if (street == "" || street.length == 0) {
              WarningToast(
                context: context,
                message: "Street is not filled.",
              ).ShowToast();
              return;
            }
            if (_province == null || _district == null || _ward == null) {
              WarningToast(
                context: context,
                message: "Address is not filled",
              ).ShowToast();
              return;
            }
            NotifyToast(
              context: context,
              message: "Feature is comming soon",
            ).ShowToast();
            
          },
          child: Container(
            color: Theme.of(context).colorScheme.background,
            padding: EdgeInsets.all(10),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryFixed,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Text(
                  "Add new address",
                  style: GoogleFonts.manrope(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
