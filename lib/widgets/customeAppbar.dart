// import 'package:customer_management/routes.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
//
//   final bool one;
//
//   final bool two;
//
//   final bool three;
//
//   final bool four;
//
//
//   const CustomAppBar({required this.one, required this.two, Key? key, required this.three, required this.four}) : super(key: key);
//
//   @override
//   State<CustomAppBar> createState() => _CustomAppBarState();
//
//   @override
//   // TODO: implement preferredSize
//   Size get preferredSize => throw UnimplementedError();
// }
//
// class _CustomAppBarState extends State<CustomAppBar> {
//
//   @override
//   Size get preferredSize => Size.fromHeight(100);
//  // Adjust the height as needed
//   @override
//   Widget build(BuildContext context) {
//     double _width = MediaQuery.of(context).size.width;
//
//     return AppBar(
//       backgroundColor: Colors.white,
//       automaticallyImplyLeading: false,
//       toolbarHeight: 100,
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           MediaQuery.of(context).size.width > 915
//               ? Image.asset(
//             'assets/logo.jpg',
//             width: 400,
//             fit: BoxFit.contain,
//             height: 160,
//           )
//               : MediaQuery.of(context).size.width > 852
//               ? Image.asset(
//             'assets/logo.jpg',
//             width: _width / 2.5,
//             fit: BoxFit.contain,
//             height: 160,
//           )
//               : Image.asset(
//             'assets/logo.jpg',
//             width: _width / 4,
//             fit: BoxFit.contain,
//             height: 160,
//           ),
//           MediaQuery.of(context).size.width > 671
//               ? Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(invoice);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   child: Text(
//                     "Invoice",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(invoiceList);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   child: Text(
//                     "Invoice list",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(customers);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   child: Text(
//                     "Customers",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(customersList);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   child: Text(
//                     "Customers List",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 10),
//             ],
//           )
//               : Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(invoice);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   child: Text(
//                     "Invoice",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 5),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(invoiceList);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   child: Text(
//                     "Invoice list",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 0),
//               SizedBox(width: 5),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(customers);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   child: Text(
//                     "Customers",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 5),
//               InkWell(
//                 onTap: () {
//                   Get.toNamed(customersList);
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   child: Text(
//                     "Customers List",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 5),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
