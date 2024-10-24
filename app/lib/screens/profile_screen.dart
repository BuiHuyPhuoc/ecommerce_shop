import 'package:ecommerce_shop/models/customerDTO.dart';
import 'package:ecommerce_shop/services/customer_services.dart';
import 'package:ecommerce_shop/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController phoneController;
  late int label = 0;
  late Future<CustomerDTO?> customer;

  Future<void> GetData() async {
    customer = GetCustomerDTOByJwtToken();
  }

  @override
  void initState() {
    GetData();
    nameController = new TextEditingController();
    phoneController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: customer,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                CustomerDTO? getCustomer = snapshot.data;
                String imagePath = getCustomer!.avatarImageUrl;
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Profile",
                                  style: GoogleFonts.manrope(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "ESC",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 140,
                            width: 140,
                            child: Stack(children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.white, width: 6),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(imagePath),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: () async {
                                    await UpdateAvatar(context);
                                    await GetData();
                                    setState(() {});
                                  },
                                  child: Container(
                                    width: 34,
                                    height: 34,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.edit_square,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ]),
                          ),
                          SizedBox(height: 10),
                          Text(
                            getCustomer.email,
                            style: GoogleFonts.manrope(
                                fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              LabelProfilePage(
                                context: context,
                                labelIndex: 0,
                                title: "Personnal Info",
                                onTap: () {
                                  setState(() {
                                    label = 0;
                                  });
                                },
                              ),
                              SizedBox(width: 20),
                              LabelProfilePage(
                                context: context,
                                labelIndex: 1,
                                title: "Sercurity",
                                onTap: () {
                                  setState(() {
                                    label = 1;
                                  });
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:
                                    Theme.of(context).colorScheme.background),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InformationField(
                                  controller: nameController,
                                  icon: Icons.person,
                                  title: "Name",
                                  content: getCustomer.name,
                                ),
                                SizedBox(height: 20),
                                InformationField(
                                    controller: phoneController,
                                    isNumberOnly: true,
                                    keyboardType: TextInputType.number,
                                    icon: Icons.phone,
                                    title: "Phone",
                                    content: getCustomer.phone),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              String name = nameController.text.trim();
                              String phone = phoneController.text.trim();
                              if (name == "" && phone == "") {
                                NotifyToast(
                                  context: context,
                                  message: "Nothing has changed",
                                ).ShowToast();
                                return;
                              }

                              if (name == "") {
                                name = getCustomer.name;
                              }

                              if (phone == "") {
                                phone = getCustomer.phone;
                              }

                              setState(() {
                                UpdateProfile(context, name, phone);
                                nameController.clear();
                                phoneController.clear();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).colorScheme.primary),
                              child: Center(
                                child: Text(
                                  "UPDATE",
                                  style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("Sonething went wrong"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget LabelProfilePage(
      {required BuildContext context,
      required String title,
      required int labelIndex,
      VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: (labelIndex == label)
              ? Border(
                  bottom: BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 2),
                )
              : Border(bottom: BorderSide.none),
        ),
        child: Text(
          title,
          style: GoogleFonts.manrope(
              color: (labelIndex == label)
                  ? Theme.of(context).colorScheme.onSecondary
                  : Theme.of(context).colorScheme.onSecondary.withOpacity(0.4),
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ),
      ),
    );
  }

  Widget InformationField(
      {String title = "",
      String content = "",
      required IconData icon,
      bool isNumberOnly = false,
      TextInputType keyboardType = TextInputType.text,
      TextEditingController? controller,
      bool readOnly = false}) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(icon),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: GoogleFonts.manrope(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              child: TextField(
                readOnly: readOnly,
                controller: controller,
                inputFormatters: (isNumberOnly)
                    ? [FilteringTextInputFormatter.digitsOnly]
                    : [],
                keyboardType: keyboardType,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: content),
                textAlign: TextAlign.right,
                style: GoogleFonts.manrope(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
