import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fpidapp/dashboard/initial/selection.dart';
import 'package:fpidapp/dashboard/manufacturer/addproducts.dart';
import 'package:fpidapp/dashboard/manufacturer/addseller.dart';
import 'package:fpidapp/dashboard/manufacturer/SellProducttoSeller.dart';
import 'package:fpidapp/dashboard/manufacturer/profile.dart';
import 'package:fpidapp/dashboard/manufacturer/querySeller.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class ManufacturerDashboard extends StatefulWidget {
  const ManufacturerDashboard({super.key});

  @override
  State<ManufacturerDashboard> createState() => _ManufacturerDashboardState();
}

class _ManufacturerDashboardState extends State<ManufacturerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manufacturer Window"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image(image: Svg("assets/add.svg")),
                                ),
                                Text("Add Products"),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddProducts()));
                            },
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Image(image: Svg("assets/verti.svg")),
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image(image: Svg("assets/add.svg")),
                                ),
                                Text("     Add Seller    "),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddSeller()));
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Divider(
                            height: 40,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image(image: Svg("assets/add.svg")),
                                ),
                                Text("Query Seller"),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuerySeller()));
                            },
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Image(
                              image: Svg("assets/verti.svg"),
                            ),
                          ),
                          InkWell(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image(image: Svg("assets/list.svg")),
                                ),
                                Text("Sell Product to Seller"),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SellProductToSeller()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: GNav(
        color: Colors.redAccent,
        backgroundColor: Colors.grey.shade300,
        tabs: [
          GButton(
            icon: Icons.exit_to_app,
            text: "LogOut",
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SelectionPage()));
            },
          ),
          GButton(
            icon: CupertinoIcons.person,
            text: "Profile",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ManufacturerProfile()));
            },
          )
        ],
      ),
    );
  }
}
