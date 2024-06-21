import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fpidapp/dashboard/consumer/consumer.dart';
import 'package:fpidapp/dashboard/manufacturer/manufacturerUI.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionPage extends StatefulWidget {
  const SelectionPage({super.key});

  @override
  State<SelectionPage> createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fake Product Identification",
              style: TextStyle(
                fontFamily: GoogleFonts.domine().fontFamily,
                fontSize: 26,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Text(
              "Choose your destination wisely !!",
              style: TextStyle(
                fontSize: 21,
                fontFamily: GoogleFonts.exo2().fontFamily,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey, width: 2)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image(
                                image: Svg("assets/manufacturer.svg"),
                              ),
                            ),
                            Text("Manufacturer"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => manufacturerUI()));
                      },
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    const SizedBox(
                      height: 50,
                      width: 25,
                      child: Image(image: Svg("assets/verti.svg")),
                    ),
                    const SizedBox(
                      width: 70,
                    ),
                    InkWell(
                      child: Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 30,
                              width: 30,
                              child: Image(image: Svg("assets/consumer.svg")),
                            ),
                            Text("Consumer"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => consumerUI()));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
