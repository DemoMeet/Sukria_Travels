import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_management/Screens/Customers/customerDetails.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  late TextEditingController _searchController;
  late Stream<QuerySnapshot> _customerStream;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _customerStream = FirebaseFirestore.instance.collection('customers').snapshots();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 100,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MediaQuery.of(context).size.width > 915
                ? Image.asset(
              'assets/logo.jpg',
              width: 400,
              fit: BoxFit.contain,
              height: 160,
            )
                : MediaQuery.of(context).size.width > 852
                ? Image.asset(
              'assets/logo.jpg',
              width: _width / 2.5,
              fit: BoxFit.contain,
              height: 160,
            )
                : Image.asset(
              'assets/logo.jpg',
              width: _width / 4,
              fit: BoxFit.contain,
              height: 160,
            ),
            MediaQuery.of(context).size.width > 671
                ? Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(homePageRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.toNamed(customers);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Customers",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.toNamed(customersList);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Customers List",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.toNamed(invoice);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Invoice",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Get.toNamed(invoiceList);
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Invoice list",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
              ],
            )
                : Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.toNamed(homePageRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Home",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Get.toNamed(customers);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Customers",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Get.toNamed(customersList);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Customers List",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Get.toNamed(invoice);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Invoice",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                InkWell(
                  onTap: () {
                    Get.toNamed(invoiceList);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Invoice list",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 0),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
              child: Row(
                children: [
                  const Text(
                    "Customers List",
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: _width / 4,),
                  Expanded(
                    child: TextFormField(

                      controller: _searchController,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        hintText: "Search...",
                        fillColor: Colors.grey[200],
                        filled: true,
                      ),
                      onChanged: (value) {
                        setState(() {

                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
                child: StreamBuilder(
                  stream: _customerStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.warning, size: 48, color: Colors.grey),
                                SizedBox(height: 10),
                                Text('No customers available', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          );
                        } else {
                          // Filtering logic based on search input
                          var filteredCustomers = snapshot.data!.docs.where((customer) {
                            String name = customer['name'].toString().toLowerCase();
                            String searchTerm = _searchController.text.toLowerCase();
                            return name.contains(searchTerm);
                          }).toList();

                          return ListView.separated(
                            itemCount: filteredCustomers.length,
                            separatorBuilder: (context, index) => SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              DocumentSnapshot customer = filteredCustomers[index];
                              return ListTile(
                                title: Row(
                                  children: [
                                    Icon(Icons.person, size: 16,),
                                    SizedBox(width: 5,),
                                    Text(
                                      customer['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Spacer(),
                                    Text("Due: ${customer['due']}"),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Icon(Icons.phone, size: 16,),
                                    SizedBox(width: 5,),
                                    Text(
                                      customer['phone'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Get.to(CustomerDetails(customer: customer));
                                },
                              );
                            },
                          );
                        }
                      }
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
