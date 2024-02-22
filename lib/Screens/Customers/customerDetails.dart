import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../routes.dart';
import '../../widgets/customer_model.dart';

class CustomerDetails extends StatefulWidget {
  final customerModel customer; 

  const CustomerDetails({Key? key, required this.customer}) : super(key: key);

  @override
  _CustomerDetailsState createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _presentAddressController;
  late TextEditingController _permanentAddressController;
  late TextEditingController _phoneController;
  late TextEditingController _dueController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.customer.name);
    _emailController = TextEditingController(text: widget.customer.email);
    _presentAddressController = TextEditingController(text: widget.customer.presentAddress);
    _permanentAddressController = TextEditingController(text: widget.customer.permanentAddress);
    _phoneController = TextEditingController(text: widget.customer.phone);
    _dueController = TextEditingController(text: widget.customer.due?.toStringAsFixed(2));
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
            MediaQuery.of(context).size.width >915? Image.asset(
              'assets/logo.jpg',
              width: 400,
              fit: BoxFit.contain,
              height: 160,
            )
                : MediaQuery.of(context).size.width >852? Image.asset(
              'assets/logo.jpg',
              width: _width/2.5,
              fit: BoxFit.contain,
              height:160,
            ): Image.asset(
              'assets/logo.jpg',
              width: _width/4,
              fit: BoxFit.contain,
              height:160,
            ),

            MediaQuery.of(context).size.width >671? Row(
              children: [
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
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),


              ],
            ),
          ],
        ),
      ),

      body: Container(
        margin: EdgeInsets.only(top: 10, left: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Edit Customer details",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Customer Name",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "E-mail adress",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _nameController,
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
                            hintText: "Customer Name",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _emailController,
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
                            hintText: "Email address",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Present Address",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Permanent Address",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _presentAddressController,
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
                            hintText: "Present Address",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _permanentAddressController,
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
                            hintText: "Permanent Address",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Contact Number",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(
                          "Payment Due",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _phoneController,
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
                            hintText: "Contact no.",
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 1,
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: TextFormField(
                          controller: _dueController,
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
                            hintText: "0.0",
                            fillColor: Colors.grey[200],
                            filled: true,

                          ),
                          // readOnly: true,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin:
                  EdgeInsets.only(top: _height / 25, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: _width/8,
                        margin: const EdgeInsets.only(
                          bottom: 40,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            _updateCustomerDetails();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2772),
                            elevation: 20,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: const Text(
                            "Update",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      // body: SingleChildScrollView(
      //   child: Container(
      //     margin: EdgeInsets.all(20),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           "Customer Name",
      //           style: TextStyle(fontSize: 16),
      //         ),
      //         TextFormField(
      //           controller: _nameController,
      //           decoration: InputDecoration(
      //             hintText: "Customer Name",
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Text(
      //           "Email Address",
      //           style: TextStyle(fontSize: 16),
      //         ),
      //         TextFormField(
      //           controller: _emailController,
      //           decoration: InputDecoration(
      //             hintText: "Email Address",
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Text(
      //           "Present Address",
      //           style: TextStyle(fontSize: 16),
      //         ),
      //         TextFormField(
      //           controller: _presentAddressController,
      //           decoration: InputDecoration(
      //             hintText: "Present Address",
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Text(
      //           "Permanent Address",
      //           style: TextStyle(fontSize: 16),
      //         ),
      //         TextFormField(
      //           controller: _permanentAddressController,
      //           decoration: InputDecoration(
      //             hintText: "Permanent Address",
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Text(
      //           "Contact Number",
      //           style: TextStyle(fontSize: 16),
      //         ),
      //         TextFormField(
      //           controller: _phoneController,
      //           decoration: InputDecoration(
      //             hintText: "Contact Number",
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         Text(
      //           "Payment Due",
      //           style: TextStyle(fontSize: 16),
      //         ),
      //         TextFormField(
      //           controller: _dueController,
      //           decoration: InputDecoration(
      //             hintText: "Payment Due",
      //           ),
      //         ),
      //         SizedBox(height: 20),
      //         ElevatedButton(
      //           onPressed: () {
      //             _updateCustomerDetails();
      //           },
      //           child: Text('Update'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }

  void _updateCustomerDetails() async {
    try {
      await FirebaseFirestore.instance
          .collection('customers')
          .doc(widget.customer.id)
          .update({
        'name': _nameController.text,
        'email': _emailController.text,
        'presentAddress': _presentAddressController.text,
        'permanentAddress': _permanentAddressController.text,
        'phone': _phoneController.text,
        'due': double.parse(_dueController.text),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Customer details updated successfully'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating customer details: $e'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _presentAddressController.dispose();
    _permanentAddressController.dispose();
    _phoneController.dispose();
    _dueController.dispose();
    super.dispose();
  }
}