import 'dart:ui';
import 'package:customer_management/Screens/Customers/customers.dart';
import 'package:customer_management/Screens/Customers/customersList.dart';
import 'package:customer_management/Screens/Invoices/InvoiceList.dart';
import 'package:customer_management/Screens/Invoices/invoice.dart';
import 'package:customer_management/routes.dart';
import 'package:page_transition/page_transition.dart';
import 'package:customer_management/Screens/Input_field_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shukriya Travels',
      defaultTransition: Transition.fadeIn,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse},
      ),
      initialRoute: homePageRoute,

      getPages: [
        GetPage(
            name: homePageRoute,
            page: () => InputFieldScreen(),
        ),
        GetPage(
          name: customers,
          page: () => Customers(),
        ),
        GetPage(
          name: customersList,
          page: () => CustomerList(),
        ),
        GetPage(
          name: invoice,
          page: () => Invoice(),
        ),
        GetPage(
          name: invoiceList,
          page: () => InvoiceList(),
        ),

      ],

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      //home: const InputFieldScreen(),
    );
  }
}
