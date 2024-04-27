import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AppBar.dart';
import '../../modeel.dart';
import '../../pdf_helper.dart';
import '../../routes.dart';

class InvoiceList extends StatefulWidget {
  const InvoiceList({Key? key}) : super(key: key);

  @override
  State<InvoiceList> createState() => _InvoiceListState();
}

class _InvoiceListState extends State<InvoiceList> {final TextEditingController searchController = TextEditingController();
 String searchString = '';

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    Future<double> getcurrentdue(String cid) async {
      double due = 0;
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(cid)
          .get()
          .then((value) {
        due = value['due'];
      });
      return due;
    }

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
                    "Flight Invoices Lists",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ),Container(width: 270,
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
                SizedBox(width: 100,),
              ],
            ),
            const SizedBox(
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
                    DataColumn(label: Text('Customer Name')),
                    DataColumn(label: Text('Airline Name')),
                    DataColumn(label: Text('Flight Number')),
                    DataColumn(label: Text('Departure')),
                    DataColumn(label: Text('Arrival')),
                    DataColumn(label: Text('Fare')),
                    DataColumn(label: Text('Action')),
                  ];
                  List<DataRow> rows = snapshot.data!.docs.where((document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    String customerName = data['selectedCustomer'].toString().toLowerCase();
                    String customerPhone = data['selectedCustomerphone'].toString().toLowerCase();
                    return customerName.contains(searchString) || customerPhone.contains(searchString);

                  }).map((document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    List<Map<String, dynamic>> travellersData =
                    List<Map<String, dynamic>>.from(data['travellers'] ?? []);
                    return DataRow(cells: [
                      DataCell(Text(data['invoicenumber'].toString())),
                      DataCell(Text(data['selectedCustomer'].toString())),
                      DataCell(Text(data['airlinename'].toString())),
                      DataCell(Text(data['flightnum'].toString())),
                      DataCell(Text(
                          "${data['departuretime']} ${data['departuredate']}")),
                      DataCell(Text(
                          "${data['arrivaltime']} ${data['arrivaldate']}")),
                      DataCell(Text(data['basefare'].toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.local_print_shop_outlined),
                            onPressed: () async {
                              InvoiceModel invoice = InvoiceModel(
                                invoicenumber: data['invoicenumber'],
                                departure: data['departure'],
                                arrival: data['arrival'],
                                airlinename: data['airlinename'],
                                flightnum: data['flightnum'],
                                departureterminal: data['departureterminal'],
                                arrivalterminal: data['arrivalterminal'],
                                departuretime: data['departuretime'],
                                arrivaltime: data['arrivaltime'],
                                departuredate: data['departuredate'],
                                arrivaldate: data['arrivaldate'],
                                basefare: data['basefare'],selectedCustomerphone: data['selectedCustomerphone'],
                                selectedCustomerid: data['selectedCustomerid'],
                                selectedCustomer: data['selectedCustomer'],
                                travellerType: data['travellerType'],
                                travellers: travellersData,
                              );
                              PdfHelper_generate.generate(
                                invoice,
                                await getcurrentdue(data['selectedCustomerid']),
                              );
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList();
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      headingRowColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      headingTextStyle: const TextStyle(
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
