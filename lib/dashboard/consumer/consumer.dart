import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:fpidapp/dashboard/consumer/cameraScan.dart';
import 'package:fpidapp/dashboard/consumer/uploadedFile.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class consumerUI extends StatefulWidget {
  const consumerUI({super.key});

  @override
  State<consumerUI> createState() => _consumerUIState();
}

class _consumerUIState extends State<consumerUI> {
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
        title: Text("Consumer"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Verify Products",
                style: TextStyle(
                    fontFamily: GoogleFonts.comfortaa().fontFamily,
                    fontSize: 20),
              ),
              SizedBox(
                height: 80,
              ),
              Center(
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
                                "Click to upload QR image",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.comfortaa().fontFamily,
                                    fontSize: 18),
                              ),
                              SizedBox(
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
                                "CLICK TO OPEN CAMERA TO SCAN",
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
