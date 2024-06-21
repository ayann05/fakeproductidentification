import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fake Product Identification",
          style: TextStyle(
            fontFamily: GoogleFonts.lato().fontFamily,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(),
      bottomNavigationBar: GNav(tabs: [
        GButton(
          icon: Icons.precision_manufacturing,
          text: 'Manufacturer',
        ),
        GButton(
          icon: Icons.man,
          text: 'Customer',
        ),
        GButton(
          icon: Icons.shopping_bag,
          text: 'Seller',
        ),
      ]),
    );
  }
}
