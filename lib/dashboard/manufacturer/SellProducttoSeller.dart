import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fpidapp/components/round_button.dart';
import 'package:fpidapp/dashboard/consumer/cameraScan.dart';
import 'package:fpidapp/dashboard/consumer/uploadedFile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SellProductToSeller extends StatefulWidget {
  const SellProductToSeller({super.key});

  @override
  State<SellProductToSeller> createState() => _ListOfProductsState();
}

class _ListOfProductsState extends State<SellProductToSeller> {
  TextEditingController productSNController = TextEditingController();
  TextEditingController sellerCodeController = TextEditingController();
  File? _image;
  String result = '';
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage == null) return;

      setState(() {
        _image = File(pickedImage.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sell Product To Seller"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sell Product to Seller",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: Colors.grey, style: BorderStyle.solid),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          InkWell(
                            child: Column(
                              children: [
                                Text(
                                  "Scan an Image File",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.comfortaa().fontFamily,
                                      fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: Image(
                                    image: Svg("assets/qr.svg"),
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              _pickImage();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          uploadedFile(image: _image)));
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                                fontFamily: GoogleFonts.comfortaa().fontFamily,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Request Camera Permissions",
                                  style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.comfortaa().fontFamily,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraScan()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const Text(
                          "Enter the details : ",
                          style: TextStyle(fontSize: 16),
                        ),
                        TextField(
                          controller: productSNController,
                          decoration:
                              InputDecoration(labelText: 'Enter Product SN'),
                        ),
                        TextField(
                          controller: sellerCodeController,
                          decoration:
                              InputDecoration(labelText: 'Enter Seller Code'),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        roundButton(title: "Sell to Seller", onPress: () {}),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
