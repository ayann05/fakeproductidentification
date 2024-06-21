import 'package:flutter/material.dart';
import 'package:fpidapp/components/round_button.dart';

class QuerySeller extends StatefulWidget {
  const QuerySeller({super.key});

  @override
  State<QuerySeller> createState() => _sellerListState();
}

class _sellerListState extends State<QuerySeller> {
  TextEditingController manufcaturerCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Seller List"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Query Seller",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Manufacturer Code",
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        TextField(
                          controller: manufcaturerCodeController,
                          decoration: InputDecoration(
                              labelText: 'Enter Manufacturer Code'),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: roundButton(
                                title: "GetSellers", onPress: () {}))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
