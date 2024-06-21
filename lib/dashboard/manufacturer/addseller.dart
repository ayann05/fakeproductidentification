import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fpidapp/components/round_button.dart';
import 'package:fpidapp/dashboard/manufacturer/manufacturerDashboard.dart';

class AddSeller extends StatefulWidget {
  const AddSeller({super.key});

  @override
  State<AddSeller> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddSeller> {
  TextEditingController sellerIdController = TextEditingController();
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController sellerBrandController = TextEditingController();
  TextEditingController sellerCodeController = TextEditingController();
  TextEditingController sellerNumController = TextEditingController();
  TextEditingController sellerManagerController = TextEditingController();
  TextEditingController sellerAddressController = TextEditingController();

  String getSellerDetails() {
    return "${sellerIdController.text}-${sellerNameController.text}-${sellerBrandController.text}-${sellerCodeController.text}-${sellerBrandController.text}${sellerNumController.text}${sellerManagerController.text}${sellerAddressController.text}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Seller'),
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
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: sellerIdController,
                    decoration: InputDecoration(labelText: 'Seller ID'),
                  ),
                  TextField(
                    controller: sellerNameController,
                    decoration: InputDecoration(labelText: 'Seller Name'),
                  ),
                  TextField(
                    controller: sellerBrandController,
                    decoration: InputDecoration(labelText: 'Seller Brand'),
                  ),
                  TextField(
                    controller: sellerCodeController,
                    decoration: InputDecoration(labelText: 'Seller Code'),
                  ),
                  TextField(
                    controller: sellerNumController,
                    decoration: InputDecoration(labelText: 'Seller Number'),
                  ),
                  TextField(
                    controller: sellerManagerController,
                    decoration: InputDecoration(labelText: 'Seller Manager'),
                  ),
                  TextField(
                    controller: sellerAddressController,
                    decoration: InputDecoration(labelText: 'Seller Address'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      child: roundButton(
                          title: "Add Seller",
                          onPress: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ManufacturerDashboard(),
                              ),
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
