import 'package:flutter/material.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            "Customer list section will update soon!"
        ),
      ),
    );
  }
}
