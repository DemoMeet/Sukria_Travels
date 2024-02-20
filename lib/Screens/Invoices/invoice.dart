import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class Invoice extends StatefulWidget {
  const Invoice({Key? key}) : super(key: key);

  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

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
                        fontWeight: FontWeight.bold,
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
                        fontWeight: FontWeight.bold,
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
      body: Center(
        child: Text(
            "Invoice section will update soon!"
        ),
      ),
    );
  }
}
