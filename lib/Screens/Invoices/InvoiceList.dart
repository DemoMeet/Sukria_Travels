import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppBar.dart';
import '../../routes.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {
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
            Container(
              margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
              child: const Text(
                "Flight Invoices Lists",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('invoice')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  const List<DataColumn> columns = [
                    DataColumn(label: Text('Invoice Number')),
                    DataColumn(label: Text('Traveller Name')),
                    DataColumn(label: Text('Customer Name')),
                    DataColumn(label: Text('Ticket Number')),
                    DataColumn(label: Text('Airline Name')),
                    DataColumn(label: Text('Flight Number')),
                    DataColumn(label: Text('Departure Terminal')),
                    DataColumn(label: Text('Departure')),
                    DataColumn(label: Text('Fare')),
                    // Add more columns as needed
                  ];

                  List<DataRow> rows = snapshot.data!.docs.map((document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return DataRow(cells: [
                      DataCell(Text(data['invoicenumber'].toString())),
                      DataCell(Text(data['traverllername'].toString())),
                      DataCell(Text(data['customername'].toString())),
                      DataCell(Text(data['ticketnumber'].toString())),
                      DataCell(Text(data['airlinename'].toString())),
                      DataCell(Text(data['flightnumber'].toString())),
                      DataCell(Text(data['departureterminal'].toString())),
                      DataCell(Text(data['departuretime'].toString() +
                          " " +
                          data['departuredate'].toString())),
                      DataCell(
                          Text((data['basefare'] + data['taxes']).toString())),
                      // Add more cells as needed
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
