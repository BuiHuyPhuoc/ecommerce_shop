import 'dart:async';

import 'package:ecommerce_shop/models/address.dart';
import 'package:ecommerce_shop/screens/add_address_screen.dart';
import 'package:ecommerce_shop/screens/signin_screen.dart';
import 'package:ecommerce_shop/services/address_services.dart';
import 'package:ecommerce_shop/widgets/custom_app_bar.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:ecommerce_shop/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectAddressScreen extends StatefulWidget {
  const SelectAddressScreen({super.key});

  @override
  State<SelectAddressScreen> createState() => _SelectAddressScreenState();
}

class _SelectAddressScreenState extends State<SelectAddressScreen> {
  int _selectedOption = 1;
  late Future<List<Address>> addresses;

  void GetData() {
    addresses = GetAddress();
  }

  @override
  void initState() {
    super.initState();
    GetData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: CustomAppBar(
          context: context,
          title: "Choose address",
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          centerTitle: false,
        ),
        body: FutureBuilder(
          future: addresses,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                if (snapshot.error.runtimeType == TimeoutException) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    NotifyToast(
                      context: context,
                      message: snapshot.error.toString(),
                    ).ShowToast();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (route) => false,
                    );
                  });
                }
                return Container(
                  child: Center(
                    child: Text("Error"),
                  ),
                );
              }
              List<Address>? getAddress = snapshot.data;
              if (getAddress == null) {
                return Container(
                  child: Center(
                    child: Text("Address not found"),
                  ),
                );
              }
              return Container(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Address",
                        style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      color: Theme.of(context).colorScheme.background,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: getAddress.length,
                        itemBuilder: (context, index) {
                          return AddressItemChoice(
                              getAddress[index], index + 1);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10);
                        },
                      ),
                    ),
                    SizedBox(height: 6),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => AddAddressScreen(),
                          ),
                        ).then((onValue) {
                          if (onValue == 'reload') {
                            GetData();
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
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
                                "Add new address",
                                style: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ),
        bottomNavigationBar: IntrinsicHeight(
          child: Container(
            padding: EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.onPrimaryFixed,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryFixed,
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  "ACCEPT",
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

  Widget AddressItemChoice(Address address, int value) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              showDialog<void>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(
                      'Delete this address?',
                      style: GoogleFonts.manrope(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryFixed),
                    ),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: <Widget>[
                          Text(
                            "Do you want to remove this address?",
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              color: Theme.of(context).colorScheme.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text('Approve'),
                        onPressed: () async {
                          LoadingDialog(context);
                          bool check = await DeleteAddress(address.id!);
                          Navigator.pop(context); // Pop loading dialog
                          try {
                            if (check) {
                              SuccessToast(
                                context: context,
                                message: "Delete address success",
                              ).ShowToast();
                              GetData();
                              setState(() {});
                            } else {
                              WarningToast(
                                context: context,
                                message: "Delete failed",
                              ).ShowToast();
                            }
                          } catch (e) {
                            WarningToast(
                              context: context,
                              message: e.toString(),
                            ).ShowToast();
                          } finally {
                            Navigator.pop(context); // Pop aleart dialog
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Del',
          ),
          SlidableAction(
            onPressed: (context) {
              NotifyToast(context: context, message: "Feature is coming soon")
                  .ShowToast();
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          )
        ],
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(top: 10),
        child: Stack(
          children: [
            GestureDetector(
              onTap: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => AddAddressScreen(
                              address: address,
                            ))).then((onValue) {
                  if (onValue == 'reload') {
                    GetData();
                    setState(() {});
                  }
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
                  Expanded(
                    child: Container(
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
                              text: address.receiverName,
                              style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Theme.of(context).colorScheme.primary,
                              ),
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
                                  text: address.receiverPhone,
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
                          Text(address.street),
                          Text(
                            "${address.ward}, ${address.district}, ${address.city}",
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
