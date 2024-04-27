import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_management/Screens/Customers/customerDetails.dart';
import 'package:customer_management/Screens/Customers/viewCustomerPage.dart';
import 'package:customer_management/widgets/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../AppBar.dart';
import '../../routes.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final TextEditingController searchController = TextEditingController();
  String searchString = '';

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myAppBar(context, _width),
      body: Container(
        margin: EdgeInsets.only(right: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
                  child: const Text(
                    "Transactions",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 320,
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search by customer name or phone',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          setState(() {
                            searchString = '';
                          });
                        },
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                  ),
                ),
                SizedBox(width: 250,),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('transactions')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  const List<DataColumn> columns = [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Customer Name')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Amount')),
                    DataColumn(label: Text('Time')),
                  ];

                  List<DataRow> rows = snapshot.data!.docs.where((document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    String customerName = data['name'].toString().toLowerCase();
                    String customerPhone = data['phone'].toString().toLowerCase();
                    return customerName.contains(searchString) || customerPhone.contains(searchString);
                  }).map((document) {
                    return DataRow(cells: [
                      DataCell(Text(document["id"])),
                      DataCell(Text(document["name"])),
                      DataCell(Text(document["phone"])),
                      DataCell(Text(document["amount"].toString())),
                      DataCell(Text(DateFormat('HH:mm yyyy-MM-dd').format(document["time"].toDate()))),
                    ]);
                  }).toList();

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      headingTextStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      columns: columns,
                      rows: rows,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
