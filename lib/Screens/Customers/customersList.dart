import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_management/Screens/Customers/customerDetails.dart';
import 'package:customer_management/Screens/Customers/viewCustomerPage.dart';
import 'package:customer_management/widgets/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../AppBar.dart';
import '../../routes.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late TextEditingController _searchController;
  late Stream<QuerySnapshot> _customerStream;
  var textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _customerStream =
        FirebaseFirestore.instance.collection('customers').snapshots();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void showMyDialog(customerModel css) {
    Get.dialog(
      AlertDialog(
        title: Text(
          'Payment Screen',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: Container(
          width: 300,
          height: 180,
          child: Column(
            children: [
              Text(
                'Payment For The Customer Name: ${css.name}',
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: textEditingController,
                keyboardType:
                    TextInputType.number, // Set keyboardType to number
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]')), // Allow only numbers
                ],
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintText: "Payment Value",
                  fillColor: Colors.grey[200],
                  filled: true,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (double.parse(textEditingController.text.toString()) <=
                          0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Amount Cannot be less then zero!'),
                          ),
                        );
                      } else if (textEditingController.text == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Amount Cannot be less then zero!'),
                          ),
                        );
                      } else if (double.parse(
                              textEditingController.text.toString()) >
                          css.due) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'The Paid Amount Cannot be higher then the Due Amount!'),
                          ),
                        );
                      } else {
                        await FirebaseFirestore.instance
                            .collection('transactions')
                            .add({
                          'name': css.name,
                          'phone': css.phone,
                          'id': css.id,
                          'amount': double.parse(
                              textEditingController.text.toString()),
                          'time': DateTime.now(),
                        }).then((value) {
                          decreaseDueAmount(
                              css.id,
                              double.parse(
                                  textEditingController.text.toString()));
                          Get.back();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Customer Payment Added Successfully!'),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void decreaseDueAmount(String documentId, double amountToDecrease) async {
    final DocumentReference documentReference =
        FirebaseFirestore.instance.collection('customers').doc(documentId);
    final DocumentSnapshot documentSnapshot = await documentReference.get();
    if (documentSnapshot.exists) {
      double currentDue = documentSnapshot['due'] ?? 0.0;
      double newDue = currentDue - amountToDecrease;
      await documentReference.update({'due': newDue});
      print('Due amount decreased successfully!');
    } else {
      print('Document does not exist.');
    }
  }

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
                "Customer Lists",
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
                    .collection('customers')
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
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Phone')),
                    DataColumn(label: Text('Present Address')),
                    DataColumn(label: Text('Permanent Address')),
                    DataColumn(label: Text('Due')),
                    DataColumn(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Text('Actions'),
                      ),
                    ),
                  ];

                  List<DataRow> rows = snapshot.data!.docs.map((document) {
                    customerModel css = customerModel(
                      due: document["due"],
                      email: document["email"],
                      permanentAddress: document["permanentAddress"],
                      presentAddress: document["presentAddress"],
                      id: document.id, // Use document.id to get the document ID
                      name: document["name"],
                      phone: document["phone"],
                    );
                    return DataRow(cells: [
                      DataCell(Text(css.id.toString())),
                      DataCell(Text(css.name.toString())),
                      DataCell(Text(css.email.toString())),
                      DataCell(Text(css.phone.toString())),
                      DataCell(Text(css.presentAddress.toString())),
                      DataCell(Text(css.permanentAddress.toString())),
                      DataCell(Text(css.due.toString())),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_red_eye_outlined),
                            onPressed: () {
                              // Navigate to view page
                              Get.to(ViewCustomerPage(customer: css));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit_outlined),
                            onPressed: () {
                              // Navigate to view page
                              Get.to(CustomerDetails(customer: css));
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.attach_money),
                            onPressed: () {
                              showMyDialog(css);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete_outline),
                            onPressed: () {},
                          ),
                        ],
                      )),
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
