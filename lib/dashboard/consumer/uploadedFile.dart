import 'dart:io';

import 'package:flutter/material.dart';

class uploadedFile extends StatefulWidget {
  final File? image;
  uploadedFile({super.key, required this.image});

  @override
  State<uploadedFile> createState() => _uploadedFileState();
}

class _uploadedFileState extends State<uploadedFile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Uploaded File"),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Uploaded QR Code",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.image != null
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.blue.shade300),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Image.file(widget.image!),
                        ),
                      )
                    : Text("No image acquired"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
