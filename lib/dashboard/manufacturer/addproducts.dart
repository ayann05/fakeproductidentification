import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fpidapp/components/round_button.dart';
import 'package:fpidapp/dashboard/manufacturer/manufacturerDashboard.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  bool dirExists = false;
  final GlobalKey _qrkey = GlobalKey();
  dynamic externalDir = '/storage/emulated/0/Download/FPIDAPP';

  Future<void> _captureAndSavePng() async {
    try {
      RenderRepaintBoundary boundary =
          _qrkey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);

      //Drawing White Background because Qr Code is Black
      final whitePaint = Paint()..color = Colors.white;
      final recorder = PictureRecorder();
      final canvas = Canvas(recorder,
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()));
      canvas.drawRect(
          Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
          whitePaint);
      canvas.drawImage(image, Offset.zero, Paint());
      final picture = recorder.endRecording();
      final img = await picture.toImage(image.width, image.height);
      ByteData? byteData = await img.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      //Check for duplicate file name to avoid Override
      String fileName = 'qr_code';
      int i = 1;
      while (await File('$externalDir/$fileName.png').exists()) {
        fileName = 'qr_code_$i';
        i++;
      }

      // Check if Directory Path exists or not
      dirExists = await File(externalDir).exists();
      //if not then create the path
      if (!dirExists) {
        await Directory(externalDir).create(recursive: true);
        dirExists = true;
      }

      final file = await File('$externalDir/$fileName.png').create();
      await file.writeAsBytes(pngBytes);

      if (!mounted) return;
      const snackBar = SnackBar(content: Text('QR code saved to gallery'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      if (!mounted) return;
      const snackBar = SnackBar(content: Text('Something went wrong!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  TextEditingController ManufacturerIDController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  TextEditingController productSNController = TextEditingController();
  TextEditingController productBrandController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();

  TextEditingController timestampController = TextEditingController();
  TextEditingController hashController = TextEditingController();
  String? selectedCategory;

  List<String> categories = [
    'Electronics',
    'Clothing',
    'Home Appliances',
    'Books',
    'Toys',
  ];

  String generatedHashCode = "";

  void generateHash() {
    String productDetails = getProductDetails();
    List<int> bytes = utf8.encode(productDetails);
    Digest sha256Result = sha256.convert(bytes);
    String hash = sha256Result.toString();
    setState(() {
      hashController.text = hash;
    });
  }

  String getProductDetails() {
    return "$selectedCategory-${ManufacturerIDController.text}-${productNameController.text}-${productSNController.text}-${productBrandController.text}-${productPriceController.text}${timestampController.text}";
  }

  void captureTimestamp() {
    DateTime now = DateTime.now();
    String formattedTimestamp =
        "${now.year}-${now.month}-${now.day} ${now.hour}:${now.minute}:${now.second}";
    setState(() {
      timestampController.text = formattedTimestamp;
    });
  }

  String hashedDetails() {
    return "${ManufacturerIDController.text}-${productNameController.text}-${productSNController.text}-${productBrandController.text}-${productPriceController.text}-Hash- ${hashController.text}";
  }

  Widget buildQrCode() {
    if (hashController.text.isNotEmpty) {
      return RepaintBoundary(
        key: _qrkey,
        child: QrImageView(
          data: hashedDetails(),
          version: QrVersions.auto,
          size: 200.0,
          gapless: true,
          errorStateBuilder: (ctx, err) {
            return const Center(
              child: Text(
                'Something went wrong!!!',
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product and QR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // DropdownButtonFormField(
                  //   value: selectedCategory,
                  //   onChanged: (value) {
                  //     setState(() {
                  //       selectedCategory = value;
                  //     });
                  //   },
                  //   items: categories.map((category) {
                  //     return DropdownMenuItem(
                  //       value: category,
                  //       child: Text(category),
                  //     );
                  //   }).toList(),
                  //   decoration: InputDecoration(labelText: 'Category'),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ManufacturerIDController,
                    decoration: InputDecoration(labelText: 'Manufacturer ID'),
                  ),
                  TextField(
                    controller: productNameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                  TextField(
                    controller: productSNController,
                    decoration: InputDecoration(labelText: 'Product SN'),
                  ),
                  TextField(
                    controller: productBrandController,
                    decoration: InputDecoration(labelText: 'Product Brand'),
                  ),
                  TextField(
                    controller: productPriceController,
                    decoration: InputDecoration(labelText: 'Product Price'),
                  ),
                  SizedBox(height: 10),
                  // TextField(
                  //   controller: timestampController,
                  //   readOnly: true,
                  //   decoration: InputDecoration(labelText: 'Timestamp'),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // ElevatedButton(
                  //   onPressed: captureTimestamp,
                  //   child: Text('Capture Timestamp'),
                  // ),
                  const SizedBox(height: 20),
                  const Divider(
                    height: 10,
                    thickness: 3,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      generateHash();
                      FocusScope.of(context).unfocus(); // Close the keyboard
                    },
                    child: Text('Generate Hash'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          hashController.text.isNotEmpty
                              ? "Generated Hash: ${hashController.text}"
                              : "Your Hash Appears here",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.blue.shade300,
                        )),
                    child: Column(
                      children: [
                        buildQrCode(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Here's your QR code image !!!",
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: roundButton(
                              title: "Tap to Save",
                              onPress: () async {
                                await _captureAndSavePng();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ManufacturerDashboard(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
