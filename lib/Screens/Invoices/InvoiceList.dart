import 'package:flutter/material.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Invoice List section will update soon!"
        ),
      ),
    );
  }
}
