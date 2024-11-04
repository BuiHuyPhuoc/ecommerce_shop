import 'dart:async';
import 'dart:convert';
import 'package:ecommerce_shop/models/address.dart';
import 'package:ecommerce_shop/services/address_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_text_field.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show FilteringTextInputFormatter, rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:search_choices/search_choices.dart';

// ignore: must_be_immutable
class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({super.key, this.address});

  Address? address;

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
  }

  void loadVietnamDistrictData() {
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

  void loadVietnamWardData() {
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

  void LoadDataWhenUpdate() async {
    await loadVietnamAddressData();
    loadVietnamDistrictData();
    loadVietnamWardData();
  }

  @override
  void initState() {
    super.initState();
    _nameController = new TextEditingController();
    _phoneNumberController = new TextEditingController();
    _streetNumberController = new TextEditingController();
    if (widget.address != null) {
      _nameController.text = widget.address!.receiverName;
      _phoneNumberController.text = widget.address!.receiverPhone;
      _streetNumberController.text = widget.address!.street;
      _province = widget.address!.city;
      _district = widget.address!.district;
      _ward = widget.address!.ward;
      setState(() {});
      LoadDataWhenUpdate();
    } else {
      loadVietnamAddressData();
    }
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

    Future<void> AddressFunction() async {
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

      if (widget.address == null) {
        // add new address
        Address newAddress = new Address(
            receiverName: name,
            receiverPhone: phone,
            city: _province!,
            district: _district!,
            ward: _ward!,
            street: street,
            isDefault: false);
        try {
          LoadingDialog(context);
          bool check = await AddAddress(newAddress);
          Navigator.pop(context);
          if (check) {
            SuccessToast(context: context, message: "Add address success")
                .ShowToast();
            // Back to address page
            Navigator.pop(context, 'reload');
          } else {
            WarningToast(context: context, message: "Add address failed")
                .ShowToast();
          }
        } catch (e) {
          Navigator.pop(context);
          WarningToast(
            context: context,
            message: e.toString(),
            duration: Duration(seconds: 2),
          ).ShowToast();
        }
      } else {
        // update address
        Address newAddress = new Address(
            id: widget.address!.id,
            receiverName: name,
            receiverPhone: phone,
            city: _province!,
            district: _district!,
            ward: _ward!,
            street: street,
            isDefault: false);
        try {
          LoadingDialog(context);
          bool check = await UpdateAddress(newAddress);
          Navigator.pop(context);
          if (check) {
            SuccessToast(context: context, message: "Update address success")
                .ShowToast();
            // Back to address page
            Navigator.pop(context, 'reload');
          } else {
            WarningToast(context: context, message: "Update address failed")
                .ShowToast();
          }
        } catch (e) {
          Navigator.pop(context);
          WarningToast(
            context: context,
            message: e.toString(),
            duration: Duration(seconds: 2),
          ).ShowToast();
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: CustomAppBar(
        context: context,
        title: "Add Address",
        leading: SizedBox(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
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
                controller: _nameController,
                context: context,
                hintText: "Full name",
                prefixIcon: Icon(
                  Icons.person_rounded,
                  color: Theme.of(context).colorScheme.primaryFixed,
                ),
              ),
              SizedBox(height: 10),
              CustomTextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.phone,
                controller: _phoneNumberController,
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
                controller: _streetNumberController,
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
          onTap: () async {
            await AddressFunction();
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
                  (widget.address == null)
                      ? "Add new address"
                      : "Update address",
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
