import 'dart:ui';
import 'package:customer_management/Screens/Customers/customers.dart';
import 'package:customer_management/Screens/Customers/customersList.dart';
import 'package:customer_management/Screens/Invoices/InvoiceList.dart';
import 'package:customer_management/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import 'package:customer_management/Screens/Input_field_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAaQdp5ZCnTXU6ToRIvdyU858AFN4L1qM8",
        authDomain: "shukriyatravels.firebaseapp.com",
        projectId: "shukriyatravels",
        storageBucket: "shukriyatravels.appspot.com",
        messagingSenderId: "818328042604",
        appId: "1:818328042604:web:8c8900389b3a4ddd3a6c49",
        measurementId: "G-H70J6S5LH4"
    )
  );

  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shukriya Travels',
      defaultTransition: Transition.fadeIn,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse},
      ),
      initialRoute: invoice,

      getPages: [
        // GetPage(
        //     name: homePageRoute,
        //     page: () => InputFieldScreen(),
        // ),
        GetPage(
          name: invoice,
          page: () => InputFieldScreen(),
        ),
        GetPage(
          name: invoiceList,
          page: () => InvoiceList(),
        ),
        GetPage(
          name: customers,
          page: () => Customers(),
        ),
        GetPage(
          name: customersList,
          page: () => CustomerList(),
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
