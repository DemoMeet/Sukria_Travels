// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:customer_management/modeel.dart';
// import 'package:customer_management/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:customer_management/pdf_helper.dart';
// import 'package:get/get.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:flutter/services.dart';
//
// import '../widgets/customer_model.dart';
//
// class InputFieldScreen extends StatefulWidget {
//   const InputFieldScreen({super.key});
//
//   @override
//   State<InputFieldScreen> createState() => _InputFieldScreenState();
// }
//
// class _InputFieldScreenState extends State<InputFieldScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;
//
//
//     final _invoicenum1 = TextEditingController(),
//         _travellername2 = TextEditingController(),
//         _ticketnumber3 = TextEditingController(),
//         _pnr4 = TextEditingController(),
//         _departure5 = TextEditingController(),
//         _arrival6 = TextEditingController(),
//         _airlinename7 = TextEditingController(),
//         _flightnum8 = TextEditingController(),
//         _aircraft9 = TextEditingController(),
//         _flightclass10 = TextEditingController(),
//         _departureterminal11 = TextEditingController(),
//         _arrivalterminal12 = TextEditingController(),
//         _departuretime13 = TextEditingController(),
//         _arrivaltime14 = TextEditingController(),
//         _departuredate15 = TextEditingController(),
//         _arrivaldate16 = TextEditingController(),
//         _basefare17 = TextEditingController(),
//         _taxes18 = TextEditingController();
//
//     final _due19 = TextEditingController();
//     // String _selectedCustomer? = TextEditingController();
//     // String? _selectedCustomer;
//     // customerModel? _selectedCustomer;
//     customerModel? _selectedCustomer;
//
//     return Scaffold(
//
//       body: Container(
//         margin: EdgeInsets.only(top: 10, left: 30),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: Container(
//             margin: EdgeInsets.only(right: _width / 6, left: _width / 6),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Add Flight Invoice",
//                   style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//                 ),
//
//
//                 Container(
//                   margin:
//                   EdgeInsets.only(top: _height / 25, left: 10, right: 10),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 10,
//                         child: Text(
//                           "Base Fare",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: SizedBox(
//                           height: 1,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 10,
//                         child: Text(
//                           "Taxes, Surcharge & Fees",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 10,
//                         child: TextFormField(
//                           controller: _basefare17,  keyboardType: TextInputType.number,
//                           inputFormatters: <TextInputFormatter>[
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           decoration: InputDecoration(
//                             enabledBorder: const OutlineInputBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.transparent),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.blue),
//                             ),
//                             hintText: "Base Fare",
//                             fillColor: Colors.grey[200],
//                             filled: true,
//                           ),
//                         ),
//                       ),
//                       const Expanded(
//                         flex: 1,
//                         child: SizedBox(
//                           height: 1,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 10,
//                         child: TextFormField(
//                           controller: _taxes18,  keyboardType: TextInputType.number,
//                           inputFormatters: <TextInputFormatter>[
//                             FilteringTextInputFormatter.digitsOnly
//                           ],
//                           decoration: InputDecoration(
//                             enabledBorder: const OutlineInputBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.transparent),
//                             ),
//                             focusedBorder: const OutlineInputBorder(
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.blue),
//                             ),
//                             hintText: "Taxes, Surcharge & Fees",
//                             fillColor: Colors.grey[200],
//                             filled: true,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//
//
//                 Container(
//                   margin:
//                   EdgeInsets.only(top: _height / 25, left: 10, right: 10),
//                   child: const Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 10,
//                         child: Text(
//                           "Due",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                       Expanded(
//                         flex: 1,
//                         child: SizedBox(
//                           height: 1,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 10,
//                         child: Text(
//                           "Customer name",
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Expanded(
//                         flex: 10,
//                         child: TextFormField(
//                           controller: _due19,
//                           decoration: InputDecoration(
//                             hintText: "Due",
//                             fillColor: Colors.grey[200],
//                             filled: true,
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.transparent),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                               borderSide: BorderSide(color: Colors.blue),
//                             ),
//                           ),
//                           readOnly: true,
//                         ),
//                       ),
//                       const Expanded(
//                         flex: 1,
//                         child: SizedBox(
//                           height: 1,
//                         ),
//                       ),
//                       Expanded(
//                         flex: 10,
//                         child: StreamBuilder<QuerySnapshot>(
//                           stream: FirebaseFirestore.instance.collection('customers').snapshots(),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return CircularProgressIndicator();
//                             } else if (snapshot.hasError) {
//                               return Text('Error: ${snapshot.error}');
//                             } else {
//                               List<customerModel> customerList = [];
//                               for (var doc in snapshot.data!.docs) {
//                                 customerList.add(customerModel(
//                                   id: doc.id,
//                                   name: doc['name'],
//                                   email: doc['email'],
//                                   permanentAddress: doc['permanentAddress'],
//                                   presentAddress: doc['presentAddress'],
//                                   phone: doc['phone'],
//                                   due: doc['due'],
//                                 ));
//                               }
//                               return DropdownButtonFormField<customerModel>(
//                                 value: _selectedCustomer,
//                                 items: customerList.map((customer) {
//                                   return DropdownMenuItem<customerModel>(
//                                     value: customer,
//                                     child: Text(customer.name!),
//                                   );
//                                 }).toList(),
//                                 onChanged: (customerModel? value) {
//                                   setState(() {
//                                     _selectedCustomer = value;
//                                     // _due19.text = _selectedCustomer!.due.toString();
//                                   });
//                                 },
//                                 decoration: InputDecoration(
//                                   hintText: 'Select Customer',
//                                   border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                                     borderSide: BorderSide(color: Colors.transparent),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                                     borderSide: BorderSide(color: Colors.blue),
//                                   ),
//                                   filled: true,
//                                   fillColor: Colors.grey[200],
//                                 ),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//
//
//
//
//                 Container(
//                   margin:
//                   EdgeInsets.only(top: _height / 25, left: 10, right: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         width: _width/8,
//                         margin: const EdgeInsets.only(
//                           bottom: 40,
//                         ),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             double bbb= double.parse(_basefare17.text);
//                             double ttt = double.parse(_taxes18.text);
//                             double total = bbb+ttt;
//                             ModelObject ss = ModelObject(invoicenum1: _invoicenum1.text, aircraft9: _aircraft9.text, airlinename7: _airlinename7.text, arrival6: _arrival6.text, arrivaldate16: _arrivaldate16.text, arrivalterminal12: _arrivalterminal12.text, arrivaltime14: _arrivaltime14.text, basefare: bbb, departure5: _departure5.text, departuredate15: _departuredate15.text, departureterminal11: _departureterminal11.text, departuretime13: _departuretime13.text, flightclass10: _flightclass10.text, flightnum8: _flightnum8.text, pnr4: _pnr4.text, taxes: ttt, ticketnumber3: _ticketnumber3.text,total: total, travellername2: _travellername2.text);
//                             PdfHelper_generate.generate(ss);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: const Color(0xFF1E2772),
//                             elevation: 20,
//                             padding: const EdgeInsets.symmetric(vertical: 20),
//                           ),
//                           child: const Text(
//                             "Submit",
//                             style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
