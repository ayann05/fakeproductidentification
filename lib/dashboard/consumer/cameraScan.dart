import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CameraScan extends StatefulWidget {
  const CameraScan({Key? key}) : super(key: key);

  @override
  State<CameraScan> createState() => _CameraScanState();
}

class _CameraScanState extends State<CameraScan> {
  String result = "";

  Future<void> _scanQR() async {
    try {
      String qrResult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.DEFAULT);
      if (!mounted)
        return; // Check if widget is still mounted before updating state
      setState(() {
        result = qrResult;
      });
    } on PlatformException {
      if (!mounted)
        return; // Check if widget is still mounted before updating state
      setState(() {
        result = 'Failed to get platform version.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('QR Scanner'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        "Click the camera to Scan the QR",
                        style: TextStyle(
                          fontFamily: GoogleFonts.comfortaa().fontFamily,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        result,
                        style:
                            const TextStyle(fontSize: 17, letterSpacing: 0.5),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Column(
                            children: [Image(image: Svg("assets/camera.svg"))],
                          ),
                        ),
                        onTap: _scanQR,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
