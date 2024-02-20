import 'package:customer_management/modeel.dart';
import 'package:customer_management/routes.dart';
import 'package:flutter/material.dart';
import 'package:customer_management/pdf_helper.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/services.dart';

class InputFieldScreen extends StatelessWidget {
  const InputFieldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;


    final _invoicenum1 = TextEditingController(),
        _travellername2 = TextEditingController(),
        _ticketnumber3 = TextEditingController(),
        _pnr4 = TextEditingController(),
        _departure5 = TextEditingController(),
        _arrival6 = TextEditingController(),
        _airlinename7 = TextEditingController(),
        _flightnum8 = TextEditingController(),
        _aircraft9 = TextEditingController(),
        _flightclass10 = TextEditingController(),
        _departureterminal11 = TextEditingController(),
        _arrivalterminal12 = TextEditingController(),
        _departuretime13 = TextEditingController(),
        _arrivaltime14 = TextEditingController(),
        _departuredate15 = TextEditingController(),
        _arrivaldate16 = TextEditingController(),
        _basefare17 = TextEditingController(),
        _taxes18 = TextEditingController();

    return Scaffold(
      appBar: AppBar(
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
                    Get.toNamed(homePageRoute);
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Home",
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
                        fontWeight: FontWeight.bold,
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add Flight Invoice",
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
                          "Invoice Number",
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
                          "Traveller Name",
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
                          controller: _invoicenum1,
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
                            hintText: "Invoice Number",
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
                          controller: _travellername2,
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
                            hintText: "Traveller Name",
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
                          "Ticket Number",
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
                          "PNR",
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
                          controller: _ticketnumber3,
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
                            hintText: "Ticket Number",
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
                          controller: _pnr4,
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
                            hintText: "PNR",
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
                          "Departure",
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
                          "Arrival",
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
                          controller: _departure5,
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
                            hintText: "Departure",
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
                          controller: _arrival6,
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
                            hintText: "Arrival",
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
                          "Airline Name",
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
                          "Flight Number",
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
                          controller: _airlinename7,
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
                            hintText: "Airline Name",
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
                          controller: _flightnum8,
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
                            hintText: "Flight Number",
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
                          "Aircraft",
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
                          "Flight Class",
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
                          controller: _aircraft9,
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
                            hintText: "Aircraft",
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
                          controller: _flightclass10,
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
                            hintText: "Flight Class",
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
                          "Departure Terminal",
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
                          "Arrival Terminal",
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
                          controller: _departureterminal11,
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
                            hintText: "Departure Terminal",
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
                          controller: _arrivalterminal12,
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
                            hintText: "Arrival Terminal",
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
                          "Departure Time",
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
                          "Arrival Time",
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
                          controller: _departuretime13,
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
                            hintText: "Departure Time",
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
                          controller: _arrivaltime14,
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
                            hintText: "Arrival Time",
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
                          "Departure Date",
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
                          "Arrival Date",
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
                          controller: _departuredate15,
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
                            hintText: "Departure Date",
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
                          controller: _arrivaldate16,
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
                            hintText: "Arrival Date",
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
                          "Base Fare",
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
                          "Taxes, Surcharge & Fees",
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
                          controller: _basefare17,  keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                            hintText: "Base Fare",
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
                          controller: _taxes18,  keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
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
                            hintText: "Taxes, Surcharge & Fees",
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
                            double bbb= double.parse(_basefare17.text);
                            double ttt = double.parse(_taxes18.text);
                            double total = bbb+ttt;
                            ModelObject ss = ModelObject(invoicenum1: _invoicenum1.text, aircraft9: _aircraft9.text, airlinename7: _airlinename7.text, arrival6: _arrival6.text, arrivaldate16: _arrivaldate16.text, arrivalterminal12: _arrivalterminal12.text, arrivaltime14: _arrivaltime14.text, basefare: bbb, departure5: _departure5.text, departuredate15: _departuredate15.text, departureterminal11: _departureterminal11.text, departuretime13: _departuretime13.text, flightclass10: _flightclass10.text, flightnum8: _flightnum8.text, pnr4: _pnr4.text, taxes: ttt, ticketnumber3: _ticketnumber3.text,total: total, travellername2: _travellername2.text);
                            PdfHelper_generate.generate(ss);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E2772),
                            elevation: 20,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                          ),
                          child: const Text(
                            "Submit",
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
    );
  }
}
